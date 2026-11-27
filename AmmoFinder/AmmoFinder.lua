local addonName, ns = ...

local PREFIX = "|cfff5b338AmmoFinder|r: "

-- Item class / subclass ids (Enum.ItemClass.Projectile = 6, Weapon = 2).
local CLASS_WEAPON, CLASS_PROJECTILE = 2, 6
local SUB_ARROW, SUB_BULLET = 2, 3
local WEAPON_BOW, WEAPON_GUN, WEAPON_CROSSBOW = 2, 3, 18
local RANGED_SLOT = 18
local AMMO_SLOT = 0

local DEFAULTS = {
    enabled = true,
    always = false,      -- announce even if no ammo-using ranged weapon is equipped
    banner = true,
    chat = true,
    sound = false,       -- play a chime with the banner
    duration = 6,        -- seconds the banner stays up (low ammo adds 2)
    cooldown = 10,       -- minutes before the same town is announced again (0 = every time)
    bannerX = 0,         -- banner offset from the middle of the screen (set by dragging it, /ammo move)
    bannerY = 260,       -- banner distance from the top of the screen, below the game's zone text
    markIcon = 1,        -- raid marker Point me there puts on the vendor (1 star .. 8 skull, 0 off)
    lowAmmo = 200,       -- warn when the equipped ammo stack is below this
    onlyLow = false,     -- only announce vendors when you have less than lowAmmo
    ammoFilter = "any",  -- "any": any ammo for the weapon, "best": the best ammo for your level, "custom": ammoItems
    ammoItems = nil,     -- [itemID] = true, the ammo picked for "custom" (filled with every item the first time)
    vendors = {},        -- learned vendors
    seedPos = {},        -- ["mapID:name"] = { x, y }: where a built-in vendor really stands, from opening their window
    seedStock = {},      -- ["mapID:name"] = { itemIDs } they really sell, or false when they sell no ammo in this game
    navStyle = "own",    -- "own": AmmoFinder's arrow, pins and map line (Waypoint.lua), "game": the game's map pin
    navArrow = true,     -- show the arrow on screen
    navLine = true,      -- show the dotted line on the world map and minimap
    arrowX = 0,          -- arrow offset from the middle of the screen (set by dragging it)
    arrowY = 150,        -- arrow distance from the top of the screen
    navTarget = nil,     -- the vendor the own waypoint points at, kept over a /reload
    snoozeUntil = nil,   -- time() until which nothing is announced (the banner's Snooze button, /ammo snooze)
}
ns.DEFAULTS = DEFAULTS

local db
local announced = {}     -- [key] = GetTime() of last announcement
local current            -- vendor the banner / `/ammo go` currently points at

local function print_(msg) print(PREFIX .. msg) end
ns.Print = print_

-- Retail moved GetItemInfoInstant into C_Item; older clients only have the global.
local function ItemInfoInstant(item)
    local fn = (C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
    if not fn then return nil end
    return fn(item)
end
ns.ItemInfoInstant = ItemInfoInstant

local function safe(v)
    if issecretvalue and issecretvalue(v) then return nil end
    return v
end

local AMMO_BY_ID = {}
for _, a in ipairs(ns.AMMO) do AMMO_BY_ID[a.id] = a end

---------------------------------------------------------------------------
-- Player ammo context
---------------------------------------------------------------------------

-- Returns "arrow", "bullet" or nil, based on the equipped ranged weapon.
local function EquippedAmmoType()
    local id = GetInventoryItemID("player", RANGED_SLOT)
    if not id then return nil end
    local _, _, _, _, _, classID, subClassID = ItemInfoInstant(id)
    if classID ~= CLASS_WEAPON then return nil end
    -- Crossbows fire arrows in Classic-era WoW (the "bolt" projectile subclass is unused).
    if subClassID == WEAPON_BOW or subClassID == WEAPON_CROSSBOW then return "arrow" end
    if subClassID == WEAPON_GUN then return "bullet" end
    return nil
end

-- Number of projectiles in the ammo slot, 0 when the slot is empty, nil when unknown.
-- GetInventoryItemCount reports 1 for an empty slot, so check the slot texture too.
local function AmmoCount()
    if GetInventoryItemTexture and not GetInventoryItemTexture("player", AMMO_SLOT) then return 0 end
    local ok, count = pcall(GetInventoryItemCount, "player", AMMO_SLOT)
    if ok and type(count) == "number" and count > 0 then return count end
    return nil
end

local function Matches(vendorAmmo, wanted)
    if not wanted or not vendorAmmo then return true end
    return vendorAmmo == "both" or vendorAmmo == wanted
end

-- The ammo items the player is looking for, as { [itemID] = true }, or nil for "any ammo".
-- wanted is the equipped weapon's ammo type, or nil when it is unknown.
local function WantedItems(wanted)
    local filter = db.ammoFilter
    if filter == "best" then
        local level = UnitLevel and UnitLevel("player") or 60
        local best = {}
        for _, a in ipairs(ns.AMMO) do
            if (not wanted or a.type == wanted) and a.level <= level then
                if not best[a.type] or a.level > best[a.type].level then best[a.type] = a end
            end
        end
        local set = {}
        for _, a in pairs(best) do set[a.id] = true end
        return set
    elseif filter == "custom" then
        local set = {}
        for id in pairs(db.ammoItems) do
            local a = AMMO_BY_ID[id]
            if a and (not wanted or a.type == wanted) then set[id] = true end
        end
        return set
    end
    return nil
end
ns.WantedItems = function(wanted) return WantedItems(wanted) end

-- Whether a vendor sells something from the wanted set. Vendors whose stock is unknown (learned before 0.4.0)
-- pass, so they keep being announced.
local function SellsWanted(v, items)
    if not items then return true end
    if not v.items then return true end
    for _, id in ipairs(v.items) do
        if items[id] then return true end
    end
    return false
end

-- The names of the wanted items a vendor sells, for the banner ("Sells Jagged Arrow")
local function WantedNames(v, items)
    if not (items and v.items) then return nil end
    local names = {}
    for _, id in ipairs(v.items) do
        if items[id] and AMMO_BY_ID[id] then names[#names + 1] = AMMO_BY_ID[id].name end
    end
    return #names > 0 and table.concat(names, ", ") or nil
end

---------------------------------------------------------------------------
-- Waypoints
---------------------------------------------------------------------------

local function SetWaypoint(v)
    if not (v and v.mapID and v.x and v.y) then
        print_("No coordinates known for that vendor yet.")
        return false
    end
    -- AmmoFinder's own arrow, pins and line (Waypoint.lua). Nothing protected, so this works in combat too
    if db.navStyle ~= "game" and ns.Nav then
        ns.Nav.Set(v)
        print_(("Pointing you to %s (%.1f, %.1f). Right-click the arrow or type /ammo clear to stop."):format(v.name, v.x, v.y))
        return true
    end
    if InCombatLockdown() then
        print_("Can't set a waypoint in combat.")
        return false
    end
    if not (C_Map and C_Map.SetUserWaypoint) then
        print_("This client has no map waypoint support.")
        return false
    end
    if C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(v.mapID) then
        print_("Waypoints aren't allowed on this map.")
        return false
    end
    local x, y = v.x / 100, v.y / 100
    local point
    if UiMapPoint and UiMapPoint.CreateFromCoordinates then
        point = UiMapPoint.CreateFromCoordinates(v.mapID, x, y)
    else
        point = { uiMapID = v.mapID, position = CreateVector2D and CreateVector2D(x, y) or { x = x, y = y } }
    end
    C_Map.SetUserWaypoint(point)
    -- Supertracking can be protected on Forever builds; only attempt it from a
    -- player click / slash command (hardware-event path), never automatically.
    if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
        pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, true)
    end
    print_(("Waypoint set to %s (%.1f, %.1f)."):format(v.name, v.x, v.y))
    return true
end

---------------------------------------------------------------------------
-- Banner
---------------------------------------------------------------------------

local TEXT_CREAM, TEXT_TAN = "|cfffff2c8", "|cffd9b36b"
local COUNT_OK, COUNT_LOW = "|cffb8e3a0", "|cffff5a4d"
local ICONS = {
    arrow = "Interface\\Icons\\INV_Ammo_Arrow_02",
    bullet = "Interface\\Icons\\INV_Ammo_Bullet_01",
    unknown = "Interface\\Icons\\INV_Misc_QuestionMark",
}
local LOW_EXTRA = 2         -- extra seconds the banner stays up when you are low on ammo
local PAD = 16              -- padding around the banner's contents
local ICON_SIZE = 40
local BUTTON_W, BUTTON_H = 190, 26
local BUTTON_GAP = 16       -- space between the ammo line and the button

local banner = CreateFrame("Frame", "AmmoFinderBanner", UIParent)
banner:SetSize(460, 120)
banner:SetPoint("TOP", UIParent, "TOP", 0, -DEFAULTS.bannerY)
banner:SetFrameStrata("HIGH")
banner:SetClampedToScreen(true)
banner:EnableMouse(false)
banner:Hide()

banner.bg = banner:CreateTexture(nil, "BACKGROUND")
banner.bg:SetAllPoints()
banner.bg:SetColorTexture(0, 0, 0, 0.45)

banner.icon = banner:CreateTexture(nil, "ARTWORK")
banner.icon:SetSize(ICON_SIZE, ICON_SIZE)
banner.icon:SetPoint("TOPLEFT", PAD + 4, -PAD)
banner.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

banner.title = banner:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
banner.title:SetPoint("TOPLEFT", banner.icon, "TOPRIGHT", 14, 0)
banner.title:SetPoint("RIGHT", banner, "RIGHT", -PAD - 22, 0) -- room for the close button
banner.title:SetJustifyH("LEFT")
banner.title:SetShadowOffset(1, -1)

banner.divider = banner:CreateTexture(nil, "ARTWORK")
banner.divider:SetHeight(2)
banner.divider:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
banner.divider:SetPoint("TOPLEFT", banner.title, "BOTTOMLEFT", 0, -3)
banner.divider:SetPoint("RIGHT", banner, "RIGHT", -PAD, 0)

banner.sub = banner:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
banner.sub:SetPoint("TOPLEFT", banner.divider, "BOTTOMLEFT", 0, -5)
banner.sub:SetPoint("RIGHT", banner, "RIGHT", -PAD, 0)
banner.sub:SetJustifyH("LEFT")

banner.ammo = banner:CreateFontString(nil, "OVERLAY", "GameFontNormal")
banner.ammo:SetPoint("TOPLEFT", banner.sub, "BOTTOMLEFT", 0, -6)
banner.ammo:SetPoint("RIGHT", banner, "RIGHT", -PAD, 0)
banner.ammo:SetJustifyH("LEFT")

banner.button = CreateFrame("Button", nil, banner, "UIPanelButtonTemplate")
banner.button:SetSize(BUTTON_W, BUTTON_H)
banner.button:SetPoint("BOTTOM", 0, PAD)
banner.button:SetText("Point me there")

banner.anim = banner:CreateAnimationGroup()
local fadeIn = banner.anim:CreateAnimation("Alpha")
fadeIn:SetFromAlpha(0); fadeIn:SetToAlpha(1); fadeIn:SetDuration(0.5); fadeIn:SetOrder(1)
if fadeIn.SetSmoothing then fadeIn:SetSmoothing("OUT") end
local hold = banner.anim:CreateAnimation("Alpha")
hold:SetFromAlpha(1); hold:SetToAlpha(1); hold:SetDuration(DEFAULTS.duration); hold:SetOrder(2)
local fadeOut = banner.anim:CreateAnimation("Alpha")
fadeOut:SetFromAlpha(1); fadeOut:SetToAlpha(0); fadeOut:SetDuration(1.2); fadeOut:SetOrder(3)
if fadeOut.SetSmoothing then fadeOut:SetSmoothing("IN") end
banner.anim:SetScript("OnFinished", function() banner:Hide() end)
ns.banner = banner

local function Dismiss()
    banner.anim:Stop()
    banner:Hide()
end

banner.button:SetScript("OnClick", function()
    if banner.unlocked then ns.LockBanner() return end
    if banner.preview then Dismiss() return end
    if SetWaypoint(banner.vendor) then Dismiss() end
end)
banner.button:SetScript("OnEnter", function(self)
    if GameTooltip and banner.vendor then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Shows you the way to " .. banner.vendor.name)
        GameTooltip:Show()
    end
    if banner.anim.Pause then banner.anim:Pause(); banner.paused = true end
end)
banner.button:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
    if banner.paused then banner.paused = false; banner.anim:Play() end
end)

---------------------------------------------------------------------------
-- Point me there, the secure version: sets the waypoint and also targets and marks the vendor
---------------------------------------------------------------------------

-- Targeting and raid markers are protected: only a real click on one of the game's secure buttons may do them. So out
-- of combat Point me there is a secure button that runs a macro (/target the vendor, then /tm) and sets the waypoint
-- after the click. It is not a child of the banner and not anchored to it, or the banner would become protected too
-- and could not show or fade in combat. Secure frames can't be changed in combat, so it is only shown out of combat
-- and hidden the moment combat starts; then the plain button above is used, which only sets the waypoint.
local secure = CreateFrame("Button", "AmmoFinderPointButton", UIParent, "SecureActionButtonTemplate, UIPanelButtonTemplate")
secure:SetSize(BUTTON_W, BUTTON_H)
secure:SetFrameStrata("HIGH")
secure:SetFrameLevel(banner:GetFrameLevel() + 10)
-- Since the 10.0 engine (which Forever and Classic run on) a secure button only acts on the half of the click that
-- matches the "cast on key down" setting (ActionButtonUseKeyDown, on by default) and ignores the other. Registered
-- for up only, the macro never ran. With both registered it runs once, on whichever half the setting picks
secure:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
secure:Hide()
banner.secure = secure

secure.anim = secure:CreateAnimationGroup()
local sFadeIn = secure.anim:CreateAnimation("Alpha")
sFadeIn:SetFromAlpha(0); sFadeIn:SetToAlpha(1); sFadeIn:SetDuration(0.5); sFadeIn:SetOrder(1)
local sHold = secure.anim:CreateAnimation("Alpha")
sHold:SetFromAlpha(1); sHold:SetToAlpha(1); sHold:SetDuration(DEFAULTS.duration); sHold:SetOrder(2)
local sFadeOut = secure.anim:CreateAnimation("Alpha")
sFadeOut:SetFromAlpha(1); sFadeOut:SetToAlpha(0); sFadeOut:SetDuration(1.2); sFadeOut:SetOrder(3)

-- Whether this client has /tm (target marker)
local function HasTargetMarker()
    return (SecureCmdList and SecureCmdList.TARGET_MARKER ~= nil) or _G.SLASH_TARGET_MARKER1 ~= nil
end

local function HideSecure()
    if InCombatLockdown() then return end
    secure.anim:Stop()
    secure:Hide()
end

-- Shows the secure button in the banner's button row for vendor v. Returns whether it is shown; when it isn't, the
-- plain button is used
function ns.ShowSecure(v, label, preview, height)
    if InCombatLockdown() or banner.unlocked or not v then
        HideSecure()
        return false
    end
    local icon = db.markIcon or 0
    local mark = icon > 0 and HasTargetMarker()
    local hasCoords = v.x ~= nil and v.y ~= nil
    if not hasCoords and not mark then
        HideSecure()
        return false
    end
    -- /cleartarget first, so that when the vendor is out of range the marker doesn't land on your old target
    local macro = mark and not preview and ("/cleartarget\n/target %s\n/tm [exists] %d"):format(v.name, icon) or nil
    secure:SetAttribute("type", macro and "macro" or nil)
    secure:SetAttribute("macrotext", macro)
    if not hasCoords then label = "Mark vendor" end
    secure:SetText(mark and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, label) or label)
    secure.vendor, secure.marks, secure.preview = v, mark, preview
    secure:ClearAllPoints()
    secure:SetPoint("TOP", UIParent, "TOP", db.bannerX or 0, -((db.bannerY or DEFAULTS.bannerY) + height - PAD - BUTTON_H))
    sHold:SetDuration(hold:GetDuration())
    secure.anim:Stop()
    secure:SetAlpha(0)
    secure:Show()
    secure.anim:Play()
    return true
end

secure.anim:SetScript("OnFinished", HideSecure)
banner:HookScript("OnHide", HideSecure)
-- After the macro: the waypoint, then the banner goes
-- The half of the click the secure button acts on (see RegisterForClicks above)
local function ActsOnDown()
    if GetCVarBool then return GetCVarBool("ActionButtonUseKeyDown") == true end
    return false
end

secure:SetScript("PostClick", function(self, _, down)
    -- Only on the same half as the macro: hiding the button on the other half would stop the macro from running
    if (down and true or false) ~= ActsOnDown() then return end
    local v = self.vendor
    if not self.preview and v then
        if self.marks then
            -- The macro has run by now: say whether the vendor ended up targeted
            local name = safe(UnitName("target"))
            if name == v.name then
                print_(("Targeted and marked %s."):format(v.name))
            elseif name == nil and UnitExists("target") then
                print_(("Tried to target and mark %s."):format(v.name)) -- name hidden from addons, can't tell
            else
                print_(("Couldn't target %s from here. Get closer and click again, or type |cffffff00/target %s|r.")
                    :format(v.name, v.name))
            end
        end
        if v.x then SetWaypoint(v) end
    end
    Dismiss()
end)
secure:HookScript("OnEnter", function(self)
    if GameTooltip and self.vendor then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText(self.vendor.x and ("Shows you the way to " .. self.vendor.name) or self.vendor.name)
        if self.marks then
            GameTooltip:AddLine("Also targets them and puts your marker on them, when they are close enough to see.",
                1, 1, 1, true)
        end
        GameTooltip:Show()
    end
    if banner.anim.Pause then banner.anim:Pause(); secure.anim:Pause(); banner.paused = true end
end)
secure:HookScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
    if banner.paused then banner.paused = false; banner.anim:Play(); secure.anim:Play() end
end)

-- The game's red X in the top right corner, to close the banner without waiting for it to fade. The banner itself
-- takes no clicks, but a child button does
banner.close = CreateFrame("Button", nil, banner, "UIPanelCloseButton")
banner.close:SetSize(26, 26)
banner.close:SetPoint("TOPRIGHT", banner, "TOPRIGHT", -2, -2)
banner.close:SetFrameLevel(banner:GetFrameLevel() + 6)
banner.close:SetScript("OnClick", function()
    Dismiss()
    HideSecure()
end)
banner.close:SetScript("OnEnter", function(self)
    if GameTooltip then
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Close")
        GameTooltip:Show()
    end
    if banner.anim.Pause then banner.anim:Pause(); secure.anim:Pause(); banner.paused = true end
end)
banner.close:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
    if banner.paused then banner.paused = false; banner.anim:Play(); secure.anim:Play() end
end)

-- Snooze: no announcements for a while. Kept in time() (real clock seconds), so it lasts over a /reload or relog
local SNOOZE_MINUTES = 30
local function Now() return (time and time()) or GetTime() end

function ns.SnoozeLeft()
    local left = db and db.snoozeUntil and (db.snoozeUntil - Now())
    if left and left > 0 then return left end
    return nil
end

function ns.Snooze(minutes)
    minutes = minutes or SNOOZE_MINUTES
    db.snoozeUntil = Now() + minutes * 60
    print_(("Snoozed for %d minutes. Type |cffffff00/ammo wake|r to turn it back on."):format(minutes))
    if ns.RefreshOptions then ns:RefreshOptions() end
end

function ns.Wake()
    local was = ns.SnoozeLeft()
    db.snoozeUntil = nil
    print_(was and "Awake again: ammo vendors are announced." or "AmmoFinder wasn't snoozed.")
    if ns.RefreshOptions then ns:RefreshOptions() end
end

-- A small button in the bottom right corner, next to Point me there
banner.snooze = CreateFrame("Button", nil, banner, "UIPanelButtonTemplate")
banner.snooze:SetSize(104, 22)
banner.snooze:SetPoint("BOTTOMRIGHT", banner, "BOTTOMRIGHT", -PAD + 4, PAD + 2)
banner.snooze:SetFrameLevel(banner:GetFrameLevel() + 6)
banner.snooze:SetText(("Snooze %d min"):format(SNOOZE_MINUTES))
banner.snooze:SetScript("OnClick", function()
    if not banner.preview then ns.Snooze() end
    Dismiss()
    HideSecure()
end)
banner.snooze:SetScript("OnEnter", function(self)
    if GameTooltip then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText(("Snooze for %d minutes"):format(SNOOZE_MINUTES))
        GameTooltip:AddLine("No banner or chat message until then. /ammo wake turns it back on.", 1, 1, 1, true)
        GameTooltip:Show()
    end
    if banner.anim.Pause then banner.anim:Pause(); secure.anim:Pause(); banner.paused = true end
end)
banner.snooze:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
    if banner.paused then banner.paused = false; banner.anim:Play(); secure.anim:Play() end
end)

function ns.ApplyBannerPosition()
    banner:ClearAllPoints()
    banner:SetPoint("TOP", UIParent, "TOP", db and db.bannerX or DEFAULTS.bannerX, -(db and db.bannerY or DEFAULTS.bannerY))
end

function ns.ResetBannerPosition()
    db.bannerX, db.bannerY = DEFAULTS.bannerX, DEFAULTS.bannerY
    ns.ApplyBannerPosition()
end

-- Move mode: the banner stays up with an amber outline and can be dragged. Its top edge is what is saved, so it grows
-- downwards from where you put it whatever text it shows. Right-click it, click its button or /ammo move to lock it
banner.move = CreateFrame("Frame", nil, banner)
banner.move:SetAllPoints()
banner.move:SetFrameLevel(banner:GetFrameLevel() + 5)
ns:Fill(banner.move, { ns.theme.accent[1], ns.theme.accent[2], ns.theme.accent[3], 0.12 }, "OVERLAY")
ns:Border(banner.move, { ns.theme.accent[1], ns.theme.accent[2], ns.theme.accent[3], 0.9 })
banner.move.label = ns:Text(banner.move, 12, ns.theme.accent, "CENTER")
banner.move.label:SetPoint("BOTTOM", banner, "TOP", 0, 6)
banner.move.label:SetText("Drag to move the banner. Right-click to lock it.")
banner.move:Hide()
banner:SetMovable(true)
banner:RegisterForDrag("LeftButton")
banner:SetScript("OnDragStart", function(self)
    if self.unlocked then self:StartMoving() end
end)
banner:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    if self.SetUserPlaced then self:SetUserPlaced(false) end -- the saved setting is the one source of the position
    local x = self:GetCenter() - UIParent:GetWidth() / 2
    local y = UIParent:GetTop() - self:GetTop()
    db.bannerX, db.bannerY = math.floor(x + 0.5), math.floor(y + 0.5)
    ns.ApplyBannerPosition()
end)
banner:SetScript("OnMouseUp", function(self, button)
    if self.unlocked and button == "RightButton" then ns.LockBanner() end
end)

function ns.UnlockBanner()
    banner.unlocked = true
    banner.move:Show()
    banner.close:Hide() -- right-click or the button locks it in move mode
    banner.snooze:Hide()
    banner:EnableMouse(true)
    ns.PreviewBanner()
    if ns.RefreshOptions then ns:RefreshOptions() end
end

function ns.LockBanner()
    banner.unlocked = false
    banner.move:Hide()
    banner.close:Show()
    banner.snooze:Show()
    banner:EnableMouse(false)
    Dismiss()
    if ns.RefreshOptions then ns:RefreshOptions() end
end

function ns.IsBannerUnlocked()
    return banner.unlocked == true
end

-- Height from the text that is shown: title, divider, vendor line and ammo line beside the icon, then the button
-- in its own row with a clear gap above and below it.
local function Layout(showButton)
    local text = (banner.title:GetStringHeight() or 0) + 3 + 2 + 5 + (banner.sub:GetStringHeight() or 0)
    if (banner.ammo:GetText() or "") ~= "" then
        text = text + 6 + (banner.ammo:GetStringHeight() or 0)
    end
    local height = PAD + math.max(text, ICON_SIZE) + PAD
    if showButton then height = height + BUTTON_GAP - PAD + BUTTON_H + PAD end
    banner:SetHeight(math.floor(height + 0.5))
end

local function ShowBanner(v, count, wanted, sells, preview)
    local ammoType = wanted or (v.ammo ~= "both" and v.ammo) or nil
    local noun = ammoType == "bullet" and "bullets" or (ammoType == "arrow" and "arrows" or "ammo")
    local empty = count ~= nil and count == 0
    local low = count ~= nil and count < (db.lowAmmo or DEFAULTS.lowAmmo)

    banner.paused = false
    banner.preview = preview
    banner.vendor = v
    banner.title:SetText(empty and "Out of Ammo!" or (low and "Low on Ammo!" or "Ammo Vendor Found"))
    if low then banner.title:SetTextColor(1, 0.3, 0.25) else banner.title:SetTextColor(1, 0.82, 0) end

    banner.icon:SetTexture(ICONS[ammoType or "arrow"] or ICONS.unknown)
    if low then banner.icon:SetVertexColor(1, 0.6, 0.6) else banner.icon:SetVertexColor(1, 1, 1) end

    local mark = db.markIcon or 0
    local line = (mark > 0 and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t "):format(mark) or "")
        .. TEXT_CREAM .. v.name .. "|r"
    if v.title then line = line .. TEXT_TAN .. " <" .. v.title .. ">|r" end
    if v.subzone and v.subzone ~= "" then line = line .. TEXT_TAN .. " \194\183 " .. v.subzone .. "|r" end
    banner.sub:SetText(line)

    local ammoLine
    if empty then
        ammoLine = COUNT_LOW .. "You are out of " .. noun .. "|r"
    elseif low then
        ammoLine = COUNT_LOW .. ("Only %d %s left"):format(count, noun) .. "|r"
    elseif count then
        ammoLine = COUNT_OK .. ("You have %d %s"):format(count, noun) .. "|r"
    end
    if sells then
        local s = TEXT_TAN .. "Sells " .. sells .. "|r"
        ammoLine = ammoLine and (ammoLine .. TEXT_TAN .. "  \194\183  |r" .. s) or s
    end
    banner.ammo:SetText(ammoLine or "")

    local hasCoords = v.x ~= nil and v.y ~= nil
    local label = low and "Restock: point me there" or "Point me there"
    banner.button:SetText(label)
    Layout(true)
    hold:SetDuration((db.duration or DEFAULTS.duration) + (low and LOW_EXTRA or 0))

    -- Out of combat the secure button (waypoint, target and mark) takes the plain button's place
    local usingSecure = ns.ShowSecure(v, label, preview, banner:GetHeight())
    banner.button:SetShown(hasCoords and not usingSecure)

    banner.anim:Stop()
    if banner.unlocked then
        banner:SetAlpha(1)
        banner:Show()
        return
    end
    banner:SetAlpha(0)
    banner:Show()
    banner.anim:Play()
    if db.sound and PlaySound then PlaySound((SOUNDKIT and SOUNDKIT.IGQUESTLOG_OPEN) or 888) end
end

-- Shows a made-up vendor, so the banner's length and position can be tried from the settings
function ns.PreviewBanner()
    local wanted = EquippedAmmoType() or "arrow"
    local items = WantedItems(wanted)
    local example = { name = "Yanni Stoutheart", subzone = "Stoutlager Inn", x = 35.6, y = 48.4, ammo = "both",
        mapID = 1432, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } }
    ShowBanner(example, AmmoCount() or 520, wanted, WantedNames(example, items), true)
end

---------------------------------------------------------------------------
-- Vendor lookup and announcement
---------------------------------------------------------------------------

local NEAR_DISTANCE = 0.07 -- map fraction (0-1); ~7% of the zone map

local function PlayerPosition(mapID)
    local pos = C_Map.GetPlayerMapPosition(mapID, "player")
    if not pos then return nil end
    local x, y = pos:GetXY()
    x, y = safe(x), safe(y)
    if x and y and (x ~= 0 or y ~= 0) then return x, y end
    return nil
end

local function Distance(v, px, py)
    if not (px and v.x and v.y) then return nil end
    local dx, dy = v.x / 100 - px, v.y / 100 - py
    return math.sqrt(dx * dx + dy * dy)
end

-- Seed vendors in a city count for the whole city; elsewhere the player has to
-- be in the vendor's subzone or standing close to them (subzone names in the
-- seed data come from the wiki and can differ slightly from the client's).
-- "arrow", "bullet" or "both" for a list of ammo item ids
local function AmmoOf(itemIDs)
    local arrow, bullet
    for _, id in ipairs(itemIDs) do
        local a = AMMO_BY_ID[id]
        if a and a.type == "arrow" then arrow = true elseif a and a.type == "bullet" then bullet = true end
    end
    return (arrow and bullet) and "both" or (arrow and "arrow" or (bullet and "bullet" or "none"))
end

local function SeedApplies(v, mapID, subzone, px, py)
    if ns.CITY_MAPS[mapID] then return true end
    if v.subzone and subzone ~= "" and v.subzone:lower() == subzone:lower() then return true end
    local d = Distance(v, px, py)
    return d ~= nil and d <= NEAR_DISTANCE
end

local function SeedHas(mapID, name)
    for _, v in ipairs(ns.SEED[mapID] or {}) do
        if v.name == name then return true end
    end
    return false
end

local function CurrentVendors(mapID, subzone, wanted, items)
    local found = {}
    local faction = safe(UnitFactionGroup("player"))
    -- The other faction's vendors won't sell to you (they're usually hostile), so skip them. No faction = neutral
    local function CanBuy(v) return not v.faction or not faction or v.faction == faction end
    local px, py = PlayerPosition(mapID)
    for _, seed in ipairs(ns.SEED[mapID] or {}) do
        -- What you saw in their window beats Data.lua: Forever moved some maps around and may have changed stock
        local key = mapID .. ":" .. seed.name
        local seen, stock = db.seedPos[key], db.seedStock[key]
        local v = seed
        if type(stock) == "table" then
            v = setmetatable({ items = stock, ammo = AmmoOf(stock) }, { __index = seed })
        end
        if stock ~= false and Matches(v.ammo, wanted) and SellsWanted(v, items) and CanBuy(v)
            and SeedApplies(v, mapID, subzone, px, py) then
            found[#found + 1] = { name = v.name, subzone = v.subzone, x = seen and seen[1] or v.x,
                y = seen and seen[2] or v.y, ammo = v.ammo, mapID = mapID, items = v.items, title = v.title,
                weapons = v.weapons }
        end
    end
    for _, v in ipairs(db.vendors) do
        local here = v.mapID == mapID and (ns.CITY_MAPS[mapID] or v.subzone == subzone)
        if here and Matches(v.ammo, wanted) and SellsWanted(v, items) and CanBuy(v) and not SeedHas(mapID, v.name) then
            found[#found + 1] = v
        end
    end
    return found, px, py
end
ns.CurrentVendors = CurrentVendors

local function Check(force)
    if not db.enabled then
        if force then print_("AmmoFinder is off. Type /ammo on to enable it.") end
        return
    end
    if not force and ns.SnoozeLeft() then return end
    local wanted = EquippedAmmoType()
    if not wanted and not db.always and not force then return end

    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return end
    local subzone = GetSubZoneText() or ""

    -- With "only when low", stay quiet while you have enough. Checked before the timeout is used up, so the town is
    -- announced once you drop below. An unreadable count still announces
    local count = AmmoCount()
    if db.onlyLow and not force and count and count >= (db.lowAmmo or DEFAULTS.lowAmmo) then return end

    local items = WantedItems(wanted)
    local vendors, px, py = CurrentVendors(mapID, subzone, wanted, items)
    if #vendors == 0 then
        current = nil -- don't let /ammo go point at a town we've left
        if force then print_("No ammo vendor here that matches your settings.") end
        return
    end

    -- One key per city, or per subzone elsewhere. The cooldown setting stops the same place being announced
    -- again every time you walk in and out of it.
    local key = (ns.CITY_MAPS[mapID] and tostring(mapID) or (mapID .. ":" .. subzone)) .. ":" .. (wanted or "any")
    local now = GetTime()
    local cooldown = (db.cooldown or DEFAULTS.cooldown) * 60
    if not force and announced[key] and now - announced[key] < cooldown then return end
    announced[key] = now

    -- Weapon merchants sell some ammo next to their weapons. Leave them out when a bowyer, gunsmith or general goods
    -- vendor here sells what you want
    local dedicated = {}
    for _, v in ipairs(vendors) do
        if not v.weapons then dedicated[#dedicated + 1] = v end
    end
    if #dedicated > 0 then vendors = dedicated end

    -- Prefer a vendor in the player's current subzone, then the nearest one with coordinates.
    local pick, best = vendors[1], nil
    for _, v in ipairs(vendors) do
        local d = Distance(v, px, py)
        if v.subzone and v.subzone:lower() == subzone:lower() then d = (d or 0) - 10 end
        if d and (not best or d < best) then pick, best = v, d end
    end
    current = pick

    if db.banner then ShowBanner(pick, count, wanted, WantedNames(pick, items)) end
    if db.chat then
        local names = {}
        for _, v in ipairs(vendors) do
            names[#names + 1] = v.name .. (v.subzone and v.subzone ~= "" and (" (" .. v.subzone .. ")") or "")
        end
        print_("Ammo vendor here: " .. table.concat(names, ", ") ..
            ((pick.x and pick.y) and "  - type |cffffff00/ammo go|r to set a waypoint." or ""))
    end
end
ns.Check = Check

---------------------------------------------------------------------------
-- Learning vendors when you open their window
---------------------------------------------------------------------------

local function LearnVendor()
    if not UnitExists("npc") then return end
    local name = safe(UnitName("npc"))
    if not name then return end

    local hasArrow, hasBullet
    local items = {}
    local complete = true -- every item in the window could be read (not still loading)
    local count = GetMerchantNumItems() or 0
    for i = 1, count do
        local link = GetMerchantItemLink(i)
        if not link then complete = false end
        if link then
            local itemID, _, _, _, _, classID, subClassID = ItemInfoInstant(link)
            if not classID then complete = false end
            if classID == CLASS_PROJECTILE then
                if subClassID == SUB_ARROW then hasArrow = true
                elseif subClassID == SUB_BULLET then hasBullet = true end
                if itemID then items[#items + 1] = itemID end
            end
        end
    end
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return end
    local pos = C_Map.GetPlayerMapPosition(mapID, "player")
    local x, y
    if pos then
        x, y = pos:GetXY()
        x, y = safe(x), safe(y)
        if x and y then x, y = x * 100, y * 100 end
    end
    local ammo = (hasArrow and hasBullet) and "both" or (hasArrow and "arrow" or "bullet")
    local subzone = GetSubZoneText() or ""
    -- Only Alliance or Horde count; anything else (nil, "Neutral") sells to both
    local faction = safe(UnitFactionGroup("npc"))
    if faction ~= "Alliance" and faction ~= "Horde" then faction = nil end

    -- Already shipped in Data.lua: remember where they really stand and what they really sell. One who sells no ammo
    -- in this game (Forever changed some stock) is not announced again
    if SeedHas(mapID, name) then
        local key = mapID .. ":" .. name
        if x and y then db.seedPos[key] = { x, y } end
        if #items > 0 then
            db.seedStock[key] = items
        elseif complete and count > 0 then
            if db.seedStock[key] ~= false then
                print_(name .. " sells no arrows or bullets here, so AmmoFinder won't send you to them again.")
            end
            db.seedStock[key] = false
        end
        return
    end
    if not (hasArrow or hasBullet) then return end

    for _, v in ipairs(db.vendors) do
        if v.name == name and v.mapID == mapID then
            v.ammo, v.subzone, v.items, v.faction = ammo, subzone, items, faction
            if x and y then v.x, v.y = x, y end
            return
        end
    end
    table.insert(db.vendors, { name = name, mapID = mapID, subzone = subzone, x = x, y = y, ammo = ammo, items = items,
        faction = faction })
    print_("Learned ammo vendor " .. name .. (subzone ~= "" and (" in " .. subzone) or "") .. ".")
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

function frame:ADDON_LOADED(name)
    if name ~= addonName then return end
    AmmoFinderDB = AmmoFinderDB or {}
    db = AmmoFinderDB
    ns.db = db
    for k, v in pairs(DEFAULTS) do
        if db[k] == nil then
            if type(v) == "table" then db[k] = {} else db[k] = v end
        end
    end
    if type(db.ammoItems) ~= "table" then
        db.ammoItems = {}
        for _, a in ipairs(ns.AMMO) do db.ammoItems[a.id] = true end
    end
    ns.ApplyBannerPosition()
    if ns.Nav then ns.Nav.Init() end
    if ns.AddSettingsPage then ns:AddSettingsPage() end
    self:UnregisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("ZONE_CHANGED")
    -- Not confirmed on every Forever build; a missing event must not break loading.
    for _, event in ipairs({ "ZONE_CHANGED_INDOORS", "MERCHANT_SHOW", "PLAYER_EQUIPMENT_CHANGED", "PLAYER_LEVEL_UP",
        "PLAYER_REGEN_DISABLED" }) do
        pcall(self.RegisterEvent, self, event)
    end
end

-- Zone text / map data is not ready the instant the event fires.
local function DelayedCheck() C_Timer.After(1.5, Check) end
frame.PLAYER_ENTERING_WORLD = DelayedCheck
frame.ZONE_CHANGED_NEW_AREA = DelayedCheck
frame.ZONE_CHANGED = DelayedCheck
frame.ZONE_CHANGED_INDOORS = DelayedCheck
frame.MERCHANT_SHOW = LearnVendor
function frame:PLAYER_EQUIPMENT_CHANGED(slot)
    if slot == RANGED_SLOT then DelayedCheck() end
end
-- A new ammo tier can unlock (levels 10, 25, 40) with "best ammo for my level"
function frame:PLAYER_LEVEL_UP()
    wipe(announced)
end
-- Fires just before combat lockdown starts: the last moment the secure button may be hidden
function frame:PLAYER_REGEN_DISABLED()
    banner.secure.anim:Stop()
    banner.secure:Hide()
    -- Swap in the plain button for the rest of the banner's time on screen
    if banner:IsShown() and banner.vendor and banner.vendor.x then banner.button:Show() end
end

frame:SetScript("OnEvent", function(self, event, ...)
    if self[event] then self[event](self, ...) end
end)

---------------------------------------------------------------------------
-- Slash commands
---------------------------------------------------------------------------

local function Toggle(key, label)
    db[key] = not db[key]
    print_(label .. ": " .. (db[key] and "on" or "off"))
    if ns.RefreshOptions then ns:RefreshOptions() end
end

local HELP = "/ammo opens the settings. Also: check | go | snooze | wake | clear | arrow | where | move | reset | test | on | off | always | banner | chat | sound | list"

SLASH_AMMOFINDER1 = "/ammo"
SLASH_AMMOFINDER2 = "/ammofinder"
SlashCmdList.AMMOFINDER = function(msg)
    local cmd = (msg or ""):lower():match("^%s*(%S*)")
    if cmd == "" or cmd == "options" or cmd == "config" or cmd == "settings" then
        ns:ToggleOptions()
    elseif cmd == "go" then
        if current then SetWaypoint(current) else print_("No ammo vendor announced yet. Try /ammo check.") end
    elseif cmd == "check" then
        Check(true)
    elseif cmd == "test" then
        ns.PreviewBanner()
    elseif cmd == "debug" then
        local yes = function(b) return b and "|cff80ff80yes|r" or "|cffff6060no|r" end
        print_("Debug:")
        print_("  /tm in this client: " .. yes(HasTargetMarker()) .. "  (SecureCmdList.TARGET_MARKER "
            .. yes(SecureCmdList and SecureCmdList.TARGET_MARKER) .. ", SLASH_TARGET_MARKER1 "
            .. tostring(_G.SLASH_TARGET_MARKER1) .. ")")
        print_("  Cast on key down: " .. yes(ActsOnDown()) .. "   In combat: " .. yes(InCombatLockdown()))
        print_("  Marker setting: " .. tostring(db.markIcon) .. "   Vendor: " .. (current and current.name or "none"))
        print_("  Secure button shown: " .. yes(secure:IsShown()) .. "   type: " .. tostring(secure:GetAttribute("type")))
        print_("  Macro: " .. tostring(secure:GetAttribute("macrotext")):gsub("\n", " | "))
    elseif cmd == "snooze" then
        ns.Snooze(tonumber((msg or ""):match("snooze%s+(%d+)")))
    elseif cmd == "wake" then
        ns.Wake()
    elseif cmd == "clear" then
        if ns.Nav and ns.Nav.Get() then ns.Nav.Clear(); print_("Waypoint cleared.") else print_("No waypoint to clear.") end
    elseif cmd == "arrow" then
        ns.Nav.ResetArrowPosition()
        print_("Arrow position reset.")
    elseif cmd == "where" then
        local mapID = C_Map.GetBestMapForUnit("player")
        local x, y
        if mapID then x, y = PlayerPosition(mapID) end
        print_(("You are at %s on map %s (%s)."):format(x and ("%.1f, %.1f"):format(x * 100, y * 100) or "an unknown position",
            tostring(mapID), GetSubZoneText() or ""))
    elseif cmd == "move" then
        if banner.unlocked then ns.LockBanner() else ns.UnlockBanner() end
    elseif cmd == "reset" then
        ns.ResetBannerPosition()
        print_("Banner position reset.")
    elseif cmd == "on" or cmd == "off" then
        db.enabled = (cmd == "on")
        print_(db.enabled and "enabled" or "disabled")
        if ns.RefreshOptions then ns:RefreshOptions() end
    elseif cmd == "always" then
        Toggle("always", "Announce even without an ammo weapon equipped")
    elseif cmd == "banner" then
        Toggle("banner", "On-screen banner")
    elseif cmd == "sound" then
        Toggle("sound", "Banner sound")
    elseif cmd == "chat" then
        Toggle("chat", "Chat message")
    elseif cmd == "list" then
        local n = 0
        for _, v in ipairs(db.vendors) do
            n = n + 1
            print_(("%s - map %d, %s %s"):format(v.name, v.mapID, v.subzone or "?", v.x and ("(%.1f, %.1f)"):format(v.x, v.y) or ""))
        end
        if n == 0 then print_("No learned vendors yet. Open an ammo vendor's window to learn one.") end
    else
        print_(HELP)
    end
end

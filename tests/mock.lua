-- A small mock of the WoW API, enough to load AmmoFinder and drive it
local M = { time = 1000, level = 30, faction = "Alliance", ranged = nil, ammoCount = 520, mapID = 1453,
    subzone = "Trade District", pos = { 0.5, 0.57 }, printed = {}, waypoint = nil, events = {}, merchant = {} }
MOCK = M

local function noop() end
local Object = {}
Object.__index = function(self, k)
    local v = rawget(Object, k)
    if v ~= nil then return v end
    if type(k) == "string" and k:match("^%u") then return noop end
end

local frames = {}
local function New(kind, parent, name)
    local o = setmetatable({ kind = kind, parent = parent, name = name, scripts = {}, shown = true, text = "",
        points = {}, enabled = true, w = 0, h = 0, children = {} }, Object)
    if parent and parent.children then table.insert(parent.children, o) end
    return o
end
function Object:SetScript(k, f) self.scripts[k] = f end
function Object:GetScript(k) return self.scripts[k] end
function Object:HookScript(k, f)
    local old = self.scripts[k]
    self.scripts[k] = old and function(...) old(...); f(...) end or f
end
function Object:SetAttribute(k, v) self.attrs = self.attrs or {}; self.attrs[k] = v end
function Object:GetAttribute(k) return self.attrs and self.attrs[k] end
function Object:Show() self.shown = true; if self.scripts.OnShow then self.scripts.OnShow(self) end end
function Object:Hide()
    if self.isSecureFrame and InCombatLockdown() then error("ADDON_ACTION_BLOCKED: Hide on secure frame in combat") end
    self.shown = false; if self.scripts.OnHide then self.scripts.OnHide(self) end
end
function Object:IsShown() return self.shown end
function Object:SetShown(s) if s then self:Show() else self:Hide() end end
function Object:SetText(t) self.text = t or "" end
function Object:GetText() return self.text end
function Object:GetStringHeight() if self.text == "" then return 0 end return self.fontHeight or 14 end
function Object:SetFontObject() end
function Object:SetSize(w, h) self.w, self.h = w, h end
function Object:SetWidth(w) self.w = w end
function Object:SetHeight(h) self.h = h end
function Object:GetHeight() return self.h end
function Object:GetFrameLevel() return 1 end
function Object:GetCenter() return self.cx or 0, self.cy or 0 end
function Object:GetTop() return self.top or 0 end
function Object:GetWidth() return self.w end
function Object:SetPoint(...) table.insert(self.points, { ... }) end
function Object:ClearAllPoints() self.points = {} end
function Object:SetEnabled(e) self.enabled = e and true or false end
function Object:IsEnabled() return self.enabled end
function Object:SetAlpha(a) self.alpha = a end
function Object:RegisterEvent(e) M.events[e] = self end
function Object:UnregisterEvent(e) M.events[e] = nil end
function Object:CreateTexture() return New("Texture", self) end
function Object:CreateFontString(_, _, template)
    local fs = New("FontString", self)
    fs.fontHeight = template == "GameFontNormalHuge" and 20 or (template == "GameFontHighlightLarge" and 16 or 12)
    return fs
end
function Object:CreateAnimationGroup()
    local g = New("AnimationGroup", self)
    g.anims = {}
    function g:CreateAnimation(kind)
        local a = New("Animation", g)
        function a:SetDuration(d) self.duration = d end
        function a:GetDuration() return self.duration end
        table.insert(g.anims, a)
        return a
    end
    function g:Play() self.playing = true end
    function g:Stop() self.playing = false end
    return g
end
function Object:SetMinMaxValues(a, b) self.min, self.max = a, b end
function Object:SetValue(v)
    v = math.max(self.min or v, math.min(self.max or v, v))
    if self.value ~= v then
        self.value = v
        if self.scripts.OnValueChanged then self.scripts.OnValueChanged(self, v) end
    end
end
function Object:GetValue() return self.value end
function Object:Click() if self.scripts.OnClick and self.enabled then self.scripts.OnClick(self, "LeftButton") end end

function CreateFrame(kind, name, parent, template)
    local f = New(kind, parent, name)
    if template == "UIPanelButtonTemplate" then f.isPanelButton = true end
    if template and template:find("SecureActionButtonTemplate") then f.isSecureFrame = true end
    if name then _G[name] = f end
    f.shown = not (kind == "Frame" and name ~= nil) and f.shown
    table.insert(frames, f)
    return f
end
UIParent = New("Frame")
UIParent.w, UIParent.top = 1920, 1080
GameTooltip = New("GameTooltip")
UISpecialFrames = {}
SlashCmdList = {}
SOUNDKIT = { IGQUESTLOG_OPEN = 875 }
function wipe(t) for k in pairs(t) do t[k] = nil end return t end
function print(...) local p = {} for i = 1, select("#", ...) do p[#p + 1] = tostring((select(i, ...))) end; table.insert(M.printed, table.concat(p, " ")) end
function GetTime() return M.time end
function InCombatLockdown() return M.combat == true end
SecureCmdList = { TARGET_MARKER = function() end }
function UnitLevel() return M.level end
function UnitFactionGroup(unit) if unit == "npc" then return M.npcFaction end return M.faction end
function UnitExists(unit) return unit == "npc" or (unit == "target" and M.targetName ~= nil) end
function UnitName(unit) if unit == "npc" then return M.npcName elseif unit == "target" then return M.targetName end end
function GetCVarBool(name) if name == "ActionButtonUseKeyDown" then return M.keyDown == true end end
function SetRaidTarget() error("ADDON_ACTION_FORBIDDEN: SetRaidTarget") end
function GetRaidTargetIndex() error("secret value") end
function GetSubZoneText() return M.subzone end
function PlaySound() M.sound = true end
function GetInventoryItemID(_, slot) if slot == 18 then return M.ranged end end
function GetInventoryItemTexture(_, slot) if slot == 0 then return M.ammoCount > 0 and 132382 or nil end end
function GetInventoryItemCount(_, slot) return M.ammoCount > 0 and M.ammoCount or 1 end
-- itemID -> class, subclass. Bow 1000, gun 1001, crossbow 1002, projectiles by id
local ITEMS = { [1000] = { 2, 2 }, [1001] = { 2, 3 }, [1002] = { 2, 18 },
    [2512] = { 6, 2 }, [2515] = { 6, 2 }, [3030] = { 6, 2 }, [11285] = { 6, 2 },
    [2516] = { 6, 3 }, [2519] = { 6, 3 }, [3033] = { 6, 3 }, [11284] = { 6, 3 }, [159] = { 0, 5 } }
function GetItemInfoInstant(item)
    local id = tonumber(item) or tonumber(tostring(item):match("item:(%d+)"))
    local i = ITEMS[id]
    if not i then return nil end
    return id, "", "", "", 0, i[1], i[2]
end
function GetItemIcon(id) return 100000 + id end
function GetMerchantNumItems() return #M.merchant end
function GetMerchantItemLink(i) return "|Hitem:" .. M.merchant[i] .. "::|h[x]|h" end
C_Timer = { After = function(_, f) f() end }
C_Map = {
    GetBestMapForUnit = function() return M.mapID end,
    GetPlayerMapPosition = function() return { GetXY = function() return M.pos[1], M.pos[2] end } end,
    SetUserWaypoint = function(p) M.waypoint = p end,
    CanSetUserWaypointOnMap = function() return true end,
}
C_SuperTrack = { SetSuperTrackedUserWaypoint = function() M.supertracked = true end }
UiMapPoint = { CreateFromCoordinates = function(map, x, y) return { uiMapID = map, x = x, y = y } end }
Settings = {
    RegisterCanvasLayoutCategory = function(panel, name) M.settingsPanel = panel; return { name = name } end,
    RegisterAddOnCategory = function(c) M.settingsCategory = c end,
}
C_AddOns = { GetAddOnMetadata = function(_, k) if k == "Version" then return "0.5.0" end end }

function M.Fire(event, ...)
    local f = M.events[event]
    if f then f.scripts.OnEvent(f, event, ...) end
end
function M.AllFrames() return frames end

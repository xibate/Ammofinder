local folder, ns = ...

--The settings: in a window that opens with /ammo, and on the addon's page in the game's settings (Options > AddOns >
--AmmoFinder). Both show the same controls in two columns: what to show and for how long on the left, which ammo to look
--for on the right. Every change applies straight away

local theme = ns.theme
local ICON = "Interface\\Icons\\INV_Ammo_Arrow_02"
local COLUMN_W = 280
local COLUMN_GAP = 32
local CONTENT_W = 2 * COLUMN_W + COLUMN_GAP
local CONTENT_H = 556

local FILTERS = {
    { key = "any", label = "Any ammo for my weapon",
      tip = "Every vendor that sells arrows (bow, crossbow) or bullets (gun)." },
    { key = "best", label = "Only the best ammo for my level",
      tip = "Only vendors that sell the highest tier you can use: level 1, 10, 25 or 40." },
    { key = "custom", label = "Only the ammo I tick below",
      tip = "Only vendors that sell at least one of the ticked kinds of ammo." },
}

local STYLES = {
    { key = "own", label = "AmmoFinder's arrow and map pins",
      tip = "An arrow on screen, a pin on the world map and minimap and a line to it. Works in combat, and clears itself when you arrive." },
    { key = "game", label = "The game's map pin",
      tip = "The game's own map waypoint. It can't be set in combat." },
}

local contents = {}

function ns:RefreshOptions()
    for _, content in ipairs(contents) do
        content:Refresh()
    end
end

local function DB()
    return ns.db
end

local function Plural(n, one, many)
    return n == 1 and one or many
end

--All the controls, in a frame of CONTENT_W x CONTENT_H
local function BuildContent(parent)
    local content = CreateFrame("Frame", nil, parent)
    content:SetSize(CONTENT_W, CONTENT_H)
    local controls = {}
    local function Add(control)
        controls[#controls + 1] = control
        return control
    end
    local function Toggle(label, key, tip)
        local check = Add(ns:Checkbox(content, label,
            function() return DB()[key] end,
            function(on) DB()[key] = on end))
        if tip then check.tooltip = function(tt) tt:SetText(label, 1, 1, 1); tt:AddLine(tip, nil, nil, nil, true) end end
        return check
    end
    local function Place(control, x, y)
        control:SetPoint("TOPLEFT", content, "TOPLEFT", x, y)
        return control
    end

    --Left column: what to show, and for how long
    local x, y = 0, 0
    Place(ns:SectionLabel(content, "Show"), x, y)
    y = y - 18
    Place(Toggle("Enabled", "enabled"), x, y); y = y - 24
    Place(Toggle("Banner on screen", "banner"), x, y); y = y - 24
    Place(Toggle("Message in chat", "chat"), x, y); y = y - 24
    Place(Toggle("Play a sound", "sound"), x, y); y = y - 24
    Place(Toggle("Also without a bow, crossbow or gun", "always",
        "Announce ammo vendors even when no ranged weapon that uses ammo is equipped."), x, y)
    y = y - 40

    Place(ns:SectionLabel(content, "Timing"), x, y)
    y = y - 20
    Place(Add(ns:Slider(content, "Show the banner for", 2, 30, 1,
        function(v) return v .. " sec" end,
        function() return DB().duration end,
        function(v) DB().duration = v end, COLUMN_W)), x, y)
    y = y - 46
    Place(Add(ns:Slider(content, "Same place again after", 0, 60, 1,
        function(v) return v == 0 and "every time" or (v .. " min") end,
        function() return DB().cooldown end,
        function(v) DB().cooldown = v end, COLUMN_W)), x, y)
    y = y - 46
    Place(Add(ns:Slider(content, "Low ammo warning below", 0, 1000, 50,
        function(v) return v == 0 and "off" or tostring(v) end,
        function() return DB().lowAmmo end,
        function(v) DB().lowAmmo = v end, COLUMN_W)), x, y)
    y = y - 40
    Place(Toggle("Only announce when below this", "onlyLow",
        "Stay quiet while you have enough ammo. A town is announced once you have less than the low ammo count."), x, y)
    y = y - 34
    --Moving the banner: unlock it, drag it where you want it, lock it again
    local move = Place(Add(ns:Button(content, "Move banner", 136, 24, function()
        if ns.IsBannerUnlocked() then ns.LockBanner() else ns.UnlockBanner() end
    end, true)), x, y)
    function move:Refresh()
        self.label:SetText(ns.IsBannerUnlocked() and "Lock banner" or "Move banner")
    end
    Place(ns:Button(content, "Reset position", 136, 24, function() ns.ResetBannerPosition() end), x + 144, y)
    y = y - 32
    Place(ns:Button(content, "Show a test banner", 136, 24, function() ns.PreviewBanner() end), x, y)

    --Right column: which ammo to look for
    x, y = COLUMN_W + COLUMN_GAP, 0
    Place(ns:SectionLabel(content, "Which ammo"), x, y)
    y = y - 18
    for _, filter in ipairs(FILTERS) do
        local radio = Add(ns:Checkbox(content, filter.label,
            function() return DB().ammoFilter == filter.key end,
            function() DB().ammoFilter = filter.key end, true))
        radio.tooltip = function(tt) tt:SetText(filter.label, 1, 1, 1); tt:AddLine(filter.tip, nil, nil, nil, true) end
        Place(radio, x, y)
        y = y - 24
    end
    y = y - 6

    --The eight kinds of vendor ammo: arrows on the left, bullets on the right, lowest tier first
    local picks = {}
    local rows = { arrow = 0, bullet = 0 }
    for _, a in ipairs(ns.AMMO) do
        local column = a.type == "arrow" and 0 or 1
        local check = ns:Checkbox(content, ("%s |cff888888%d|r"):format(a.name, a.level),
            function() return DB().ammoItems[a.id] end,
            function(on) DB().ammoItems[a.id] = on or nil end)
        check:SetWidth(128)
        local icon = (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(a.id)) or (GetItemIcon and GetItemIcon(a.id))
        check:SetIcon(icon)
        check.tooltip = function(tt)
            if tt.SetItemByID then tt:SetItemByID(a.id) else tt:SetText(a.name, 1, 1, 1) end
        end
        Place(check, x + 18 + column * 132, y - rows[a.type] * 24)
        rows[a.type] = rows[a.type] + 1
        picks[#picks + 1] = Add(check)
    end
    y = y - 4 * 24 - 10

    local note = Place(ns:Text(content, 11, theme.dim), x, y)
    note:SetWidth(COLUMN_W)
    note:SetWordWrap(true)
    note:SetJustifyV("TOP")
    note:SetText("What each vendor sells comes from Wowhead Classic. Vendors you met yourself remember what they sold. "
        .. "The number is the level you need to use it.")

    local status = Place(ns:Text(content, 11, theme.warning), x, y - 44)
    status:SetWidth(COLUMN_W)
    status:SetWordWrap(true)

    --The raid marker put on the vendor: Off, then star to skull
    y = y - 88
    Place(ns:SectionLabel(content, "Mark the vendor"), x, y)
    y = y - 18
    local function MarkButton(icon, bx)
        local button = CreateFrame("Button", nil, content)
        button:SetSize(icon == 0 and 34 or 22, 22)
        ns:Fill(button, theme.input)
        local setBorder = ns:Border(button, theme.borderStrong)
        if icon == 0 then
            button.text = ns:Text(button, 11, theme.text, "CENTER")
            button.text:SetPoint("CENTER")
            button.text:SetText("Off")
        else
            local texture = button:CreateTexture(nil, "ARTWORK")
            texture:SetPoint("TOPLEFT", 3, -3)
            texture:SetPoint("BOTTOMRIGHT", -3, 3)
            texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. icon)
        end
        function button:Refresh()
            if DB().markIcon == icon then
                setBorder(ns.Color(theme.accent, 1))
            else
                setBorder(1, 1, 1, 0.15)
            end
            self:SetAlpha((DB().markIcon == icon or icon ~= 0) and 1 or 0.7)
        end
        button:SetScript("OnClick", function()
            DB().markIcon = icon
            ns:RefreshOptions()
        end)
        return Place(Add(button), bx, y)
    end
    MarkButton(0, x)
    for icon = 1, 8 do
        MarkButton(icon, x + 38 + (icon - 1) * 26)
    end
    y = y - 30
    local markNote = Place(ns:Text(content, 11, theme.dim), x, y)
    markNote:SetWidth(COLUMN_W)
    markNote:SetWordWrap(true)
    markNote:SetText("Clicking Point me there also targets the vendor and puts this marker on them.")

    --How Point me there shows the way: AmmoFinder's own arrow, pins and line, or the game's map pin
    y = y - 40
    Place(ns:SectionLabel(content, "Show the way with"), x, y)
    y = y - 18
    for _, style in ipairs(STYLES) do
        local radio = Add(ns:Checkbox(content, style.label,
            function() return DB().navStyle == style.key end,
            function() DB().navStyle = style.key end, true))
        radio.tooltip = function(tt) tt:SetText(style.label, 1, 1, 1); tt:AddLine(style.tip, nil, nil, nil, true) end
        Place(radio, x, y)
        y = y - 24
    end
    local navArrow = Place(Toggle("Arrow on screen", "navArrow",
        "An arrow that points at the vendor, with the distance. It turns green when you face them. Drag it to move it, "
        .. "right-click it to stop."), x + 18, y)
    y = y - 24
    local navLine = Place(Toggle("Dotted line on the map and minimap", "navLine",
        "A moving line from you to the vendor on the world map and the minimap, like a GPS."), x + 18, y)
    y = y - 30
    Place(ns:Button(content, "Reset arrow", 136, 24, function() ns.Nav.ResetArrowPosition() end), x, y)
    Place(ns:Button(content, "Clear the way", 136, 24, function()
        if ns.Nav.Get() then ns.Nav.Clear(); ns.Print("Waypoint cleared.") end
    end), x + 144, y)

    local commands = Place(ns:Text(content, 11, theme.section), 0, -(CONTENT_H - 16))
    commands:SetWidth(CONTENT_W)
    commands:SetText("/ammo go  show the way     /ammo clear  stop     /ammo check  look again here     /ammo move  move the banner")

    function content:Refresh()
        if not DB() then return end
        local custom = DB().ammoFilter == "custom"
        for _, check in ipairs(picks) do
            check:SetEnabled(custom)
        end
        navArrow:SetEnabled(DB().navStyle ~= "game")
        navLine:SetEnabled(DB().navStyle ~= "game")
        for _, control in ipairs(controls) do
            control:Refresh()
        end
        local text = ""
        if custom then
            local n = 0
            for _ in pairs(DB().ammoItems) do n = n + 1 end
            if n == 0 then text = "Nothing is ticked, so no vendor will be announced." end
        elseif DB().ammoFilter == "best" then
            local level = UnitLevel and UnitLevel("player") or 1
            local names = {}
            for i, a in ipairs(ns.AMMO) do
                local next_ = ns.AMMO[i + 1]
                if a.level <= level and not (next_ and next_.type == a.type and next_.level <= level) then
                    names[#names + 1] = a.name
                end
            end
            text = ("At level %d that is %s."):format(level, table.concat(names, " and "))
        end
        if DB().onlyLow and DB().lowAmmo == 0 then
            text = "Only when low is on but the low ammo count is off, so nothing will be announced. " .. text
        end
        local snoozed = ns.SnoozeLeft and ns.SnoozeLeft()
        if snoozed then
            text = ("Snoozed for %d more min. Type /ammo wake to turn it back on. "):format(math.ceil(snoozed / 60)) .. text
        end
        if not DB().enabled then
            text = "AmmoFinder is off. " .. text
        end
        status:SetText(text)
    end
    content:SetScript("OnShow", content.Refresh)
    table.insert(contents, content)
    return content
end

------------------------------------------------------------------------------------------------------------------------
-- The window, with /ammo
------------------------------------------------------------------------------------------------------------------------

local window

local function CreateWindow()
    window = CreateFrame("Frame", "AmmoFinderOptions", UIParent)
    window:SetSize(CONTENT_W + 40, CONTENT_H + 110)
    window:SetPoint("CENTER", 0, 40)
    window:SetFrameStrata("DIALOG")
    window:SetClampedToScreen(true)
    window:EnableMouse(true)
    window:SetMovable(true)
    window:RegisterForDrag("LeftButton")
    window:SetScript("OnDragStart", window.StartMoving)
    window:SetScript("OnDragStop", window.StopMovingOrSizing)
    window:Hide()
    table.insert(UISpecialFrames, "AmmoFinderOptions")
    ns:Fill(window, theme.window)
    ns:Border(window, theme.border)
    local strip = window:CreateTexture(nil, "ARTWORK")
    strip:SetHeight(2)
    strip:SetPoint("TOPLEFT", 1, -1)
    strip:SetPoint("TOPRIGHT", -1, -1)
    strip:SetColorTexture(ns:GetAccent())
    local logo = window:CreateTexture(nil, "ARTWORK")
    logo:SetSize(20, 20)
    logo:SetPoint("TOPLEFT", 16, -12)
    logo:SetTexture(ICON)
    logo:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    local name = ns:Text(window, 14)
    name:SetPoint("LEFT", logo, "RIGHT", 8, 0)
    name:SetText("AmmoFinder")
    name:SetTextColor(ns:GetAccent())
    local close = ns:Button(window, "x", 22, 22, function() window:Hide() end)
    close:SetPoint("TOPRIGHT", -10, -10)
    window.content = BuildContent(window)
    window.content:SetPoint("TOPLEFT", 20, -50)
    local done = ns:Button(window, "Done", 96, 26, function() window:Hide() end, 'solid')
    done:SetPoint("BOTTOMRIGHT", -16, 16)
end

function ns:OpenOptions()
    if not window then
        CreateWindow()
    end
    window:Show()
    window.content:Refresh()
end

function ns:ToggleOptions()
    if window and window:IsShown() then
        window:Hide()
    else
        ns:OpenOptions()
    end
end

--For tests
function ns:GetOptionsWindow()
    return window
end

------------------------------------------------------------------------------------------------------------------------
-- The addon's page in the game's settings
------------------------------------------------------------------------------------------------------------------------

local GetMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

function ns:AddSettingsPage()
    local panel = CreateFrame("Frame")
    local logo = panel:CreateTexture(nil, "ARTWORK")
    logo:SetSize(24, 24)
    logo:SetPoint("TOPLEFT", 16, -16)
    logo:SetTexture(ICON)
    logo:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    local name = ns:Text(panel, 16)
    name:SetPoint("LEFT", logo, "RIGHT", 10, 0)
    name:SetText("AmmoFinder")
    local version = ns:Text(panel, 11, theme.dim)
    version:SetPoint("LEFT", name, "RIGHT", 8, -1)
    version:SetText(GetMetadata and GetMetadata(folder, "Version") or "")
    panel.content = BuildContent(panel)
    panel.content:SetPoint("TOPLEFT", 16, -60)
    panel:SetScript("OnShow", function() panel.content:Refresh() end)
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, "AmmoFinder")
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        panel.name = "AmmoFinder"
        InterfaceOptions_AddCategory(panel)
    end
end

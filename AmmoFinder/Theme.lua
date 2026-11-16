local _, ns = ...

--Look of the settings window, the same as Crescendo's and Easy Delete's: dark warm panels, faint 1px borders, dimmed
--white text and one accent colour, in the style of EllesmereUI. The accent is amber, like the banner's gold title. With
--EllesmereUI installed its font is used, so the window matches the rest of the UI
local theme = {
    window = { 0.069, 0.058, 0.047, 0.97 },
    panel = { 0.089, 0.080, 0.072, 1 },
    well = { 0.030, 0.023, 0.018, 0.6 },
    input = { 0.103, 0.095, 0.088, 0.9 },
    border = { 1, 1, 1, 0.06 },
    borderStrong = { 1, 1, 1, 0.22 },
    text = { 1, 1, 1, 0.9 },
    dim = { 1, 1, 1, 0.53 },
    section = { 1, 1, 1, 0.41 },
    warning = { 1, 0.75, 0.3, 1 },
    accent = { 0.96, 0.70, 0.22 }
}
ns.theme = theme

local DEFAULT_FONT = "Fonts\\FRIZQT__.TTF"

function ns:GetAccent()
    return theme.accent[1], theme.accent[2], theme.accent[3]
end

function ns:GetFont()
    local eui = _G.EllesmereUI
    if type(eui) == 'table' and type(eui.GetFontPath) == 'function' then
        local ok, path = pcall(eui.GetFontPath)
        if ok and type(path) == 'string' then
            return path
        end
    end
    return DEFAULT_FONT
end

local function Color(color, alpha)
    return color[1], color[2], color[3], alpha or color[4] or 1
end
ns.Color = Color

--A solid colour filling a frame
function ns:Fill(frame, color, layer)
    local texture = frame:CreateTexture(nil, layer or "BACKGROUND")
    texture:SetColorTexture(Color(color))
    texture:SetAllPoints()
    return texture
end

--A 1px border around a frame, made of four textures so it stays sharp. Returns a function that recolours it
function ns:Border(frame, color)
    local edges = {}
    local function Edge(pointA, pointB, horizontal)
        local edge = frame:CreateTexture(nil, "BORDER")
        edge:SetPoint(pointA)
        edge:SetPoint(pointB)
        if horizontal then
            edge:SetHeight(1)
        else
            edge:SetWidth(1)
        end
        table.insert(edges, edge)
    end
    Edge("TOPLEFT", "TOPRIGHT", true)
    Edge("BOTTOMLEFT", "BOTTOMRIGHT", true)
    Edge("TOPLEFT", "BOTTOMLEFT", false)
    Edge("TOPRIGHT", "BOTTOMRIGHT", false)
    local function SetColor(r, g, b, a)
        for _, edge in ipairs(edges) do
            edge:SetColorTexture(r, g, b, a)
        end
    end
    SetColor(Color(color or theme.border))
    return SetColor
end

function ns:Text(parent, size, color, justify)
    local text = parent:CreateFontString(nil, "OVERLAY")
    text:SetFont(ns:GetFont(), size or 12, "")
    text:SetShadowColor(0, 0, 0, 0.8)
    text:SetShadowOffset(1, -1)
    text:SetTextColor(Color(color or theme.text))
    text:SetJustifyH(justify or "LEFT")
    text:SetWordWrap(false)
    return text
end

--A small upper case section label
function ns:SectionLabel(parent, label)
    local text = ns:Text(parent, 10, theme.section)
    text:SetText(label:upper())
    return text
end

--A flat button with a faint border that lights up on hover. 'accent' gives it the accent colour, 'solid' fills it with
--the accent colour with white text
function ns:Button(parent, label, width, height, onClick, accent)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(width, height or 24)
    local background = ns:Fill(button, theme.panel)
    local setBorder = ns:Border(button, theme.borderStrong)
    button.label = ns:Text(button, 11, theme.text, "CENTER")
    button.label:SetPoint("CENTER")
    button.label:SetText(label)
    local function Paint(hover)
        if accent == 'solid' then
            local r, g, b = ns:GetAccent()
            background:SetColorTexture(r, g, b, hover and 1 or 0.9)
            setBorder(r, g, b, 1)
            button.label:SetTextColor(0, 0, 0, 0.9)
            return
        elseif accent then
            local r, g, b = ns:GetAccent()
            background:SetColorTexture(r, g, b, hover and 0.32 or 0.2)
            setBorder(r, g, b, hover and 0.9 or 0.6)
        else
            background:SetColorTexture(Color(theme.panel, hover and 0.95 or 0.65))
            setBorder(1, 1, 1, hover and 0.35 or 0.2)
        end
        button.label:SetTextColor(1, 1, 1, hover and 1 or 0.75)
    end
    Paint(false)
    button:SetScript("OnEnter", function() Paint(true) end)
    button:SetScript("OnLeave", function() Paint(false) end)
    button:SetScript("OnClick", function(self)
        if onClick then
            onClick(self)
        end
    end)
    return button
end

--A tick box (or, with 'radio', a round-looking choice) with a label. get() says whether it is on, set(on) is called on
--a click. Call :Refresh() after the setting changed elsewhere
function ns:Checkbox(parent, label, get, set, radio)
    local check = CreateFrame("Button", nil, parent)
    check:SetSize(260, 20)
    local box = CreateFrame("Frame", nil, check)
    box:SetSize(14, 14)
    box:SetPoint("LEFT", 0, 0)
    ns:Fill(box, theme.input)
    local setBorder = ns:Border(box, theme.borderStrong)
    local mark = box:CreateTexture(nil, "ARTWORK")
    local inset = radio and 4 or 3
    mark:SetPoint("TOPLEFT", inset, -inset)
    mark:SetPoint("BOTTOMRIGHT", -inset, inset)
    mark:SetColorTexture(ns:GetAccent())
    check.label = ns:Text(check, 12)
    check.label:SetPoint("LEFT", box, "RIGHT", 8, 0)
    check.label:SetText(label)
    check.icon = check:CreateTexture(nil, "ARTWORK")
    check.icon:SetSize(14, 14)
    check.icon:SetPoint("LEFT", box, "RIGHT", 8, 0)
    check.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    check.icon:Hide()
    local hover = false
    function check:Refresh()
        local on = get() and true or false
        local enabled = self:IsEnabled()
        mark:SetShown(on)
        if on then
            setBorder(ns.Color(theme.accent, 0.8))
        else
            setBorder(1, 1, 1, hover and 0.4 or 0.22)
        end
        self.label:SetTextColor(1, 1, 1, not enabled and 0.3 or ((hover or on) and 0.95 or 0.75))
        self.icon:SetDesaturated(not enabled)
        self:SetAlpha(enabled and 1 or 0.7)
    end
    --An item icon between the box and the label
    function check:SetIcon(texture)
        if texture then
            self.icon:SetTexture(texture)
            self.icon:Show()
            self.label:SetPoint("LEFT", box, "RIGHT", 28, 0)
        end
    end
    check:SetScript("OnEnter", function(self)
        hover = true
        self:Refresh()
        if self.tooltip and GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            self.tooltip(GameTooltip)
            GameTooltip:Show()
        end
    end)
    check:SetScript("OnLeave", function(self)
        hover = false
        self:Refresh()
        if GameTooltip then GameTooltip:Hide() end
    end)
    check:SetScript("OnClick", function(self)
        set(not get())
        ns:RefreshOptions()
    end)
    return check
end

--A labelled slider with its value on the right: "Show the banner for       6 sec". format(value) gives the value text
function ns:Slider(parent, label, minValue, maxValue, step, format, get, set, width)
    width = width or 260
    local holder = CreateFrame("Frame", nil, parent)
    holder:SetSize(width, 34)
    local title = ns:Text(holder, 12)
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(label)
    local value = ns:Text(holder, 12, theme.accent, "RIGHT")
    value:SetPoint("TOPRIGHT", 0, 0)
    local slider = CreateFrame("Slider", nil, holder)
    slider:SetOrientation("HORIZONTAL")
    slider:SetPoint("TOPLEFT", 0, -18)
    slider:SetPoint("TOPRIGHT", 0, -18)
    slider:SetHeight(14)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValueStep(step)
    if slider.SetObeyStepOnDrag then slider:SetObeyStepOnDrag(true) end
    slider:EnableMouseWheel(true)
    local track = slider:CreateTexture(nil, "BACKGROUND")
    track:SetPoint("LEFT", 0, 0)
    track:SetPoint("RIGHT", 0, 0)
    track:SetHeight(4)
    track:SetColorTexture(ns.Color(theme.input))
    local thumb = slider:CreateTexture(nil, "ARTWORK")
    thumb:SetSize(8, 14)
    thumb:SetColorTexture(ns:GetAccent())
    slider:SetThumbTexture(thumb)
    holder.slider = slider
    local refreshing = false
    local function Snap(v)
        return math.floor((v - minValue) / step + 0.5) * step + minValue
    end
    slider:SetScript("OnValueChanged", function(_, v)
        v = Snap(v)
        value:SetText(format(v))
        if not refreshing and v ~= get() then
            set(v)
        end
    end)
    slider:SetScript("OnMouseWheel", function(self, delta)
        local v = math.max(minValue, math.min(maxValue, Snap(self:GetValue()) + delta * step))
        self:SetValue(v)
    end)
    function holder:Refresh()
        refreshing = true
        slider:SetValue(get())
        value:SetText(format(get()))
        refreshing = false
    end
    return holder
end

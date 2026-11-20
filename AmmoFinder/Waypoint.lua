local addonName, ns = ...

-- AmmoFinder's own waypoint, used instead of the game's map pin unless you pick that in the settings:
--  - an arrow on screen that points at the vendor, with the distance, like a GPS (drag it to move, right-click to stop)
--  - a pin on the world map and the minimap (on the minimap's edge when the vendor is further away)
--  - a moving dotted line from you to the vendor on both maps
-- None of this is protected, so unlike the game's waypoint it also works in combat. It clears itself when you arrive.

local MEDIA = "Interface\\AddOns\\" .. addonName .. "\\Media\\"
local ARRIVE_YARDS = 8          -- this close counts as arrived
local UPDATE_EVERY = 0.03       -- seconds between updates
local AMBER = { 0.96, 0.70, 0.22 }
local GREEN = { 0.45, 0.92, 0.35 }
local LINE_SPEED = 1.5          -- how fast the dots move along the line, in gaps between dots a second

-- Minimap diameter in yards for each zoom level, indoors and outdoors (as measured for HereBeDragons-Pins)
local MINIMAP_YARDS = {
    indoor = { 300, 240, 180, 120, 80, 50 },
    outdoor = { 466 + 2 / 3, 400, 333 + 1 / 3, 266 + 2 / 3, 200, 133 + 1 / 3 },
}

local atan2 = math.atan2 or math.atan
local sqrt, abs, cos, sin, pi = math.sqrt, math.abs, math.cos, math.sin, math.pi

local Nav = {}
ns.Nav = Nav

local target -- { name, mapID, x, y (0-100), continent, north, west (world yards) }

local function safe(v)
    if issecretvalue and issecretvalue(v) then return nil end
    return v
end

local function DB() return ns.db end

local function Own()
    return DB() and DB().navStyle ~= "game"
end

---------------------------------------------------------------------------
-- Positions. The world uses yards: x grows to the north, y to the west
---------------------------------------------------------------------------

local function WorldPos(mapID, x, y)
    if not (mapID and C_Map and C_Map.GetWorldPosFromMapPos and CreateVector2D) then return nil end
    local ok, continent, pos = pcall(C_Map.GetWorldPosFromMapPos, mapID, CreateVector2D(x, y))
    if not (ok and pos) then return nil end
    local north, west = pos:GetXY()
    continent, north, west = safe(continent), safe(north), safe(west)
    if not (continent and north and west) then return nil end
    return continent, north, west
end

local function PlayerMapPos(mapID)
    if not mapID then return nil end
    local pos = C_Map.GetPlayerMapPosition(mapID, "player")
    if not pos then return nil end
    local x, y = pos:GetXY()
    x, y = safe(x), safe(y)
    if not (x and y) or (x == 0 and y == 0) then return nil end
    return x, y
end

-- How far the vendor is (yards), the direction (radians counterclockwise from north, like GetPlayerFacing) and the
-- offset north and east. nil, "continent" when they are on another continent
local function Relative()
    if not (target and target.continent) then return nil end
    local mapID = safe(C_Map.GetBestMapForUnit("player"))
    local x, y = PlayerMapPos(mapID)
    if not x then return nil end
    local continent, north, west = WorldPos(mapID, x, y)
    if not continent then return nil end
    if continent ~= target.continent then return nil, "continent" end
    local dn, dw = target.north - north, target.west - west
    return sqrt(dn * dn + dw * dw), atan2(dw, dn), dn, -dw
end
Nav.Relative = Relative

local function Facing()
    return GetPlayerFacing and safe(GetPlayerFacing()) or nil
end

---------------------------------------------------------------------------
-- The dotted line: dots from one point to another, moving towards the end
---------------------------------------------------------------------------

local function DrawDots(pool, parent, point, x1, y1, x2, y2, gap, size, skipStart, skipEnd)
    local dx, dy = x2 - x1, y2 - y1
    local len = sqrt(dx * dx + dy * dy)
    local n = 0
    if len > 0 and gap > 0 then
        local d = skipStart + (GetTime() * LINE_SPEED * gap) % gap
        while d < len - skipEnd and n < 300 do
            n = n + 1
            local dot = pool[n]
            if not dot then
                dot = parent:CreateTexture(nil, "OVERLAY", nil, 6)
                dot:SetTexture(MEDIA .. "Dot")
                dot:SetVertexColor(AMBER[1], AMBER[2], AMBER[3])
                pool[n] = dot
            end
            dot:SetSize(size, size)
            dot:ClearAllPoints()
            dot:SetPoint("CENTER", parent, point, x1 + dx * d / len, y1 + dy * d / len)
            dot:Show()
            d = d + gap
        end
    end
    for i = n + 1, #pool do pool[i]:Hide() end
end

local function HideDots(pool)
    for _, dot in ipairs(pool) do dot:Hide() end
end

---------------------------------------------------------------------------
-- The arrow
---------------------------------------------------------------------------

local arrow = CreateFrame("Button", "AmmoFinderArrow", UIParent)
arrow:SetSize(140, 96)
arrow:SetFrameStrata("MEDIUM")
arrow:SetClampedToScreen(true)
arrow:SetMovable(true)
arrow:EnableMouse(true)
arrow:RegisterForDrag("LeftButton")
arrow:RegisterForClicks("RightButtonUp")
arrow:Hide()
Nav.arrow = arrow

arrow.icon = arrow:CreateTexture(nil, "ARTWORK")
arrow.icon:SetSize(56, 56)
arrow.icon:SetPoint("TOP", 0, 0)
arrow.icon:SetTexture(MEDIA .. "Arrow")

arrow.name = arrow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
arrow.name:SetPoint("TOP", arrow.icon, "BOTTOM", 0, -2)
arrow.name:SetShadowOffset(1, -1)

arrow.dist = arrow:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
arrow.dist:SetPoint("TOP", arrow.name, "BOTTOM", 0, -2)
arrow.dist:SetShadowOffset(1, -1)

function Nav.ApplyArrowPosition()
    local db = DB()
    if not db then return end
    arrow:ClearAllPoints()
    arrow:SetPoint("TOP", UIParent, "TOP", db.arrowX or 0, -(db.arrowY or 150))
end

function Nav.ResetArrowPosition()
    local db = DB()
    db.arrowX, db.arrowY = ns.DEFAULTS.arrowX, ns.DEFAULTS.arrowY
    Nav.ApplyArrowPosition()
end

arrow:SetScript("OnDragStart", function(self) self:StartMoving() end)
arrow:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    if self.SetUserPlaced then self:SetUserPlaced(false) end
    local db = DB()
    local x, top = self:GetCenter(), self:GetTop()
    if db and x and top then
        db.arrowX = math.floor(x - UIParent:GetWidth() / 2 + 0.5)
        db.arrowY = math.floor(UIParent:GetTop() - top + 0.5)
    end
    Nav.ApplyArrowPosition()
end)
arrow:SetScript("OnClick", function(_, button)
    if button == "RightButton" then
        Nav.Clear()
        ns.Print("Waypoint cleared.")
    end
end)
arrow:SetScript("OnEnter", function(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    GameTooltip:SetText(target and target.name or "AmmoFinder")
    GameTooltip:AddLine("Drag to move the arrow. Right-click to stop.", 1, 1, 1, true)
    GameTooltip:Show()
end)
arrow:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

local function FormatYards(yards)
    return ("%d yards"):format(math.floor(yards + 0.5))
end

local function Rotate(texture, angle)
    if texture.SetRotation then texture:SetRotation(angle) end
end

local function UpdateArrow(dist, bearing, reason)
    if not DB().navArrow then arrow:Hide() return end
    arrow:Show()
    arrow.name:SetText(target.name)
    local facing = Facing()
    if dist and facing then
        local angle = bearing - facing
        Rotate(arrow.icon, angle)
        -- Amber, turning green as you face the vendor
        local off = abs(((angle + pi) % (2 * pi)) - pi) -- 0 straight ahead, pi behind you
        local t = math.max(0, 1 - off / (pi / 3))
        arrow.icon:SetVertexColor(AMBER[1] + (GREEN[1] - AMBER[1]) * t, AMBER[2] + (GREEN[2] - AMBER[2]) * t,
            AMBER[3] + (GREEN[3] - AMBER[3]) * t)
        arrow.icon:SetAlpha(1)
        arrow.dist:SetText(FormatYards(dist))
    else
        Rotate(arrow.icon, 0)
        arrow.icon:SetVertexColor(0.6, 0.6, 0.6)
        arrow.icon:SetAlpha(0.5)
        arrow.dist:SetText(reason == "continent" and "On another continent" or
            (dist and FormatYards(dist) or "Distance unknown"))
    end
end

---------------------------------------------------------------------------
-- The minimap: a pin (on the edge when further away) and the line to it
---------------------------------------------------------------------------

local mini
local function MinimapLayer()
    if mini or not Minimap then return mini end
    mini = CreateFrame("Frame", nil, Minimap)
    mini:SetAllPoints(Minimap)
    mini:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 5)
    mini.pin = mini:CreateTexture(nil, "OVERLAY", nil, 7)
    mini.pin:SetSize(14, 14)
    mini.pin:SetTexture(MEDIA .. "Pin")
    mini.pin:SetVertexColor(AMBER[1], AMBER[2], AMBER[3])
    mini.dots = {}
    return mini
end

local function UpdateMinimap(dist, north, east)
    local layer = MinimapLayer()
    if not layer then return end
    if not dist then layer:Hide() return end
    layer:Show()
    local zoom = (Minimap.GetZoom and Minimap:GetZoom()) or 0
    local sizes = (IsIndoors and IsIndoors()) and MINIMAP_YARDS.indoor or MINIMAP_YARDS.outdoor
    local radius = (Minimap:GetWidth() or 140) / 2
    local scale = radius / ((sizes[zoom + 1] or sizes[1]) / 2)
    local ex, ny = east, north
    if GetCVar and GetCVar("rotateMinimap") == "1" then
        local f = -(Facing() or 0)
        ex, ny = ex * cos(f) - ny * sin(f), ex * sin(f) + ny * cos(f)
    end
    local px, py = ex * scale, ny * scale
    local len = sqrt(px * px + py * py)
    local edge = radius - 7
    local onEdge = len > edge
    if onEdge then px, py = px / len * edge, py / len * edge end
    layer.pin:ClearAllPoints()
    layer.pin:SetPoint("CENTER", Minimap, "CENTER", px, py)
    layer.pin:SetAlpha(onEdge and 0.75 or 1)
    if DB().navLine then
        DrawDots(layer.dots, layer, "CENTER", 0, 0, px, py, 8, 5, 7, 7)
    else
        HideDots(layer.dots)
    end
    Nav.miniPin = { px, py, onEdge } -- for tests
end

---------------------------------------------------------------------------
-- The world map: a pin and the line from you, on any map that shows the vendor
---------------------------------------------------------------------------

local map
local function MapLayer()
    if map then return map end
    if not (WorldMapFrame and WorldMapFrame.GetCanvas) then return nil end
    local canvas = WorldMapFrame:GetCanvas()
    if not canvas then return nil end
    map = CreateFrame("Frame", nil, canvas)
    map:SetAllPoints(canvas)
    map:SetFrameLevel((canvas:GetFrameLevel() or 1) + 500)
    map.pin = map:CreateTexture(nil, "OVERLAY", nil, 7)
    map.pin:SetTexture(MEDIA .. "Pin")
    map.pin:SetVertexColor(AMBER[1], AMBER[2], AMBER[3])
    map.dots = {}
    return map
end

-- Where the vendor is on the map being looked at (0-1), also when that is the zone or continent around them
local function TargetOnMap(mapID)
    if mapID == target.mapID then return target.x / 100, target.y / 100 end
    if not (target.continent and C_Map.GetMapPosFromWorldPos and CreateVector2D) then return nil end
    local ok, _, pos = pcall(C_Map.GetMapPosFromWorldPos, target.continent,
        CreateVector2D(target.north, target.west), mapID)
    if not (ok and pos) then return nil end
    local x, y = pos:GetXY()
    return safe(x), safe(y)
end

local function UpdateWorldMap()
    local layer = MapLayer()
    if not layer then return end
    if not WorldMapFrame:IsShown() then layer:Hide() return end
    local mapID = WorldMapFrame:GetMapID()
    local tx, ty = TargetOnMap(mapID)
    if not (tx and ty) or tx < 0 or tx > 1 or ty < 0 or ty > 1 then layer:Hide() return end
    layer:Show()
    local w, h = layer:GetWidth(), layer:GetHeight()
    -- Zooming the map scales the canvas; divide by that so the pin and dots keep their size
    local scroll = WorldMapFrame.ScrollContainer
    local s = (scroll and scroll.GetCanvasScale and scroll:GetCanvasScale()) or 1
    layer.pin:SetSize(22 / s, 22 / s)
    layer.pin:ClearAllPoints()
    layer.pin:SetPoint("CENTER", layer, "TOPLEFT", tx * w, -ty * h)
    local px, py = PlayerMapPos(mapID)
    if DB().navLine and px then
        DrawDots(layer.dots, layer, "TOPLEFT", px * w, -py * h, tx * w, -ty * h, 14 / s, 7 / s, 12 / s, 12 / s)
    else
        HideDots(layer.dots)
    end
end

---------------------------------------------------------------------------
-- Setting and clearing
---------------------------------------------------------------------------

local driver = CreateFrame("Frame")
driver:Hide()

function Nav.Clear()
    target = nil
    if DB() then DB().navTarget = nil end
    driver:Hide()
    arrow:Hide()
    if mini then mini:Hide() end
    if map then map:Hide() end
end

function Nav.Update()
    if not target then return end
    if not Own() then Nav.Clear() return end
    local dist, bearing, north, east = Relative()
    local reason = not dist and bearing or nil -- "continent" when they are on another continent
    if dist and dist <= ARRIVE_YARDS then
        ns.Print("You have arrived at " .. target.name .. ".")
        Nav.Clear()
        return
    end
    UpdateArrow(dist, bearing, reason)
    UpdateMinimap(dist, north, east)
    UpdateWorldMap()
end

local elapsed = 0
driver:SetScript("OnUpdate", function(_, dt)
    elapsed = elapsed + dt
    if elapsed < UPDATE_EVERY then return end
    elapsed = 0
    Nav.Update()
end)

-- v: { name, mapID, x, y } with x, y in 0-100
function Nav.Set(v)
    local continent, north, west = WorldPos(v.mapID, v.x / 100, v.y / 100)
    target = { name = v.name, mapID = v.mapID, x = v.x, y = v.y, continent = continent, north = north, west = west }
    DB().navTarget = { name = v.name, mapID = v.mapID, x = v.x, y = v.y }
    elapsed = 0
    driver:Show()
    Nav.Update()
    return true
end

function Nav.Get() return target end

-- After loading: put the arrow in place and pick up a waypoint from before a /reload
function Nav.Init()
    Nav.ApplyArrowPosition()
    local saved = DB().navTarget
    if saved and saved.mapID and saved.x and saved.y and Own() then Nav.Set(saved) end
end

-- Runs after mock.lua and the addon files. ns is the addon table
local ns, M = AF_NS, MOCK
local passed, failed = 0, 0
local function ok(cond, label)
    if cond then passed = passed + 1 else failed = failed + 1; io.write("FAIL: " .. label, string.char(10)) end
end
local banner = ns.banner
local hold = banner.anim.anims[2]
local function Reset()
    banner:Hide(); M.printed = {}; M.waypoint = nil
end
local function Enter(mapID, subzone, x, y)
    M.mapID, M.subzone, M.pos = mapID, subzone, { x, y }
    Reset()
    M.Fire("ZONE_CHANGED")
    return banner:IsShown()
end

M.Fire("ADDON_LOADED", "AmmoFinder")
local db = AmmoFinderDB
ok(db.duration == 6 and db.cooldown == 10 and db.bannerY == 260 and db.ammoFilter == "any", "defaults")
local n = 0 for _ in pairs(db.ammoItems) do n = n + 1 end
ok(n == 8, "all 8 ammo picked by default")
ok(M.settingsPanel ~= nil, "settings page registered")

-- Data: every vendor has items, and its ammo type agrees with them
local ARROW = { [2512] = true, [2515] = true, [3030] = true, [11285] = true }
local vendors, bad = 0, {}
for map, list in pairs(ns.SEED) do
    for _, v in ipairs(list) do
        vendors = vendors + 1
        local a, b = false, false
        for _, id in ipairs(v.items or {}) do if ARROW[id] then a = true else b = true end end
        local t = a and b and "both" or (a and "arrow" or (b and "bullet" or "none"))
        if t ~= v.ammo then bad[#bad + 1] = v.name end
    end
end
ok(vendors == 111, "111 vendors, got " .. vendors)
ok(#bad == 0, "ammo type matches items: " .. table.concat(bad, ", "))

-- No weapon: nothing
M.ranged = nil
ok(not Enter(1453, "Trade District", 0.5, 0.57), "no announce without ranged weapon")

-- Bow in Stormwind
M.ranged = 1000
ok(Enter(1453, "Trade District", 0.5, 0.57), "bow in Stormwind shows banner")
ok(banner.button:IsShown(), "button shown")
ok(hold.duration == 6, "hold uses duration setting")
-- Spacing: ammo line bottom to button top
local textH = 20 + 3 + 2 + 5 + 16 + 6 + 12
local buttonTop = banner.h - 16 - 26
ok(buttonTop - (16 + textH) >= 16, ("button gap >= 16 (banner %d, gap %d)"):format(banner.h, buttonTop - (16 + textH)))
ok(banner.sub.text:find("Stover") ~= nil or banner.sub.text:find("Weller") ~= nil or banner.sub.text:find("Mullby") ~= nil, "nearby vendor picked: " .. banner.sub.text)

-- Cooldown
ok(not Enter(1453, "Old Town", 0.5, 0.57), "same city within cooldown: quiet")
M.time = M.time + 9 * 60
ok(not Enter(1453, "Trade District", 0.5, 0.57), "still quiet after 9 min")
M.time = M.time + 2 * 60
ok(Enter(1453, "Trade District", 0.5, 0.57), "announced again after 11 min")
db.cooldown = 0
ok(Enter(1453, "Trade District", 0.5, 0.57) and Enter(1453, "Trade District", 0.5, 0.57), "cooldown 0: every time")

-- Duration
db.duration = 15
Enter(1453, "Trade District", 0.5, 0.57)
ok(hold.duration == 15, "duration 15 applied")
M.ammoCount = 50
Enter(1453, "Trade District", 0.5, 0.57)
ok(hold.duration == 17 and banner.title.text == "Low on Ammo!", "low ammo adds 2s and red title")
M.ammoCount = 520

-- Best ammo for level
db.ammoFilter = "best"
M.level = 30
Enter(1453, "Trade District", 0.5, 0.57)
ok(banner.ammo.text:find("Razor Arrow") ~= nil, "best at 30 = Razor Arrow: " .. banner.ammo.text)
M.level = 5
Enter(1453, "Trade District", 0.5, 0.57)
ok(banner.ammo.text:find("Rough Arrow") ~= nil, "best at 5 = Rough Arrow")
M.level = 45
-- Ironforge: Bryllia Ironbrand sells up to Razor; Skolmin Goldfury sells Jagged
Enter(1455, "The Commons", 0.39, 0.738)
local said = table.concat(M.printed, " ")
ok(said:find("Skolmin") and not said:find("Thalgus"), "best at 45 skips Thalgus (no Jagged Arrow): " .. said)
-- Gun at 45 in Goldshire area (Elwynn): check a vendor without Accurate Slugs is skipped
M.ranged = 1001
local wanted = ns.WantedItems("bullet")
ok(wanted[11284] and not wanted[3033], "best bullets at 45 = Accurate Slugs")

-- Custom
db.ammoFilter = "custom"
M.ranged = 1000
db.ammoItems = {}
ok(not Enter(1453, "Trade District", 0.5, 0.57), "custom with nothing ticked: quiet")
db.ammoItems = { [2515] = true }
ok(Enter(1453, "Trade District", 0.5, 0.57) and banner.ammo.text:find("Sharp Arrow"), "custom Sharp Arrow")
db.ammoItems = { [2519] = true } -- bullets only, but a bow is equipped
ok(not Enter(1453, "Trade District", 0.5, 0.57), "custom bullets with a bow: quiet")
db.ammoFilter = "any"
db.ammoItems = { [2512] = true }

-- Waypoint button
Enter(1453, "Trade District", 0.5, 0.57)
ok(banner:IsShown(), "shown before click")
banner.button:Click()
ok(M.waypoint and M.waypoint.uiMapID == 1453 and not banner:IsShown(), "button sets waypoint and dismisses")

-- Position setting
db.bannerY = 300
ns.ApplyBannerPosition()
ok(banner.points[1][5] == -300, "banner position applied")

-- Learning a vendor records its stock
M.mapID, M.subzone, M.npcName = 1432, "Thelsamar", "New Guy"
M.merchant = { 159, 2512, 2516 }
M.Fire("MERCHANT_SHOW")
local learned = db.vendors[#db.vendors]
ok(learned and learned.name == "New Guy" and learned.ammo == "both" and #learned.items == 2, "learned vendor with items")

-- Settings window
SlashCmdList.AMMOFINDER("")
local window = ns:GetOptionsWindow()
ok(window and window:IsShown(), "/ammo opens the window")
local function Find(frame, pred, out)
    out = out or {}
    if pred(frame) then out[#out + 1] = frame end
    for _, c in ipairs(frame.children or {}) do Find(c, pred, out) end
    return out
end
local content = window.content
local checks = Find(content, function(f) return f.kind == "Button" and f.label and f.label.text ~= nil end)
local function Check(label)
    for _, c in ipairs(checks) do if c.label.text:find(label, 1, true) == 1 then return c end end
end
local chat = Check("Message in chat")
db.chat = true; chat:Click()
ok(db.chat == false, "chat toggle")
Check("Only the best ammo"):Click()
ok(db.ammoFilter == "best", "radio best")
ok(not Check("Jagged Arrow"):IsEnabled(), "picks disabled unless custom")
Check("Only the ammo I tick"):Click()
ok(db.ammoFilter == "custom" and Check("Jagged Arrow"):IsEnabled(), "picks enabled in custom")
local jag = Check("Jagged Arrow")
local before = db.ammoItems[11285]
jag:Click()
ok(db.ammoItems[11285] ~= before, "pick toggles item")
local sliders = Find(content, function(f) return f.kind == "Slider" end)
ok(#sliders == 4, "4 sliders, got " .. #sliders)
sliders[1]:SetValue(12.4)
ok(db.duration == 12, "duration slider snaps to 12, got " .. tostring(db.duration))
sliders[2]:SetValue(30)
ok(db.cooldown == 30, "cooldown slider")
sliders[4]:SetValue(400)
ok(db.bannerY == 400 and banner.points[1][5] == -400, "position slider moves banner")
SlashCmdList.AMMOFINDER("test")
ok(banner:IsShown() and banner.preview, "/ammo test previews")
banner.button:Click()
ok(not banner:IsShown(), "preview button just closes")

io.write(("%d passed, %d failed" .. string.char(10)):format(passed, failed))

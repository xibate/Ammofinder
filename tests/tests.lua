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
ok(db.navStyle == "own" and db.navArrow and db.navLine, "own waypoint, arrow and line by default")
-- The tests below this use the game's map pin; AmmoFinder's own waypoint is tested at the end
db.navStyle = "game"

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
ok(banner.secure:IsShown() and not banner.button:IsShown(), "secure button shown")
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

-- Opening a built-in vendor's window corrects their position, without adding a duplicate
local before = #db.vendors
M.mapID, M.subzone, M.npcName, M.pos = 1453, "Trade District", "Thurman Mullby", { 0.646, 0.714 }
M.merchant = { 2512, 2516 }
M.Fire("MERCHANT_SHOW")
ok(#db.vendors == before and db.seedPos["1453:Thurman Mullby"], "built-in vendor position saved, not duplicated")
db.cooldown, db.ammoFilter, db.ammoItems = 0, "any", { [2512] = true }
M.ranged = 1000
Enter(1453, "Trade District", 0.646, 0.714)
ok(banner.sub.text:find("Thurman Mullby"), "nearest is Mullby at his seen spot: " .. banner.sub.text)
SlashCmdList.AMMOFINDER("go")
ok(M.waypoint and math.abs(M.waypoint.x - 0.646) < 0.001 and math.abs(M.waypoint.y - 0.714) < 0.001,
    "waypoint uses the seen position")
-- Faction: the other side's vendors are skipped, built in or learned; neutral ones count for both
M.faction = "Horde"
ok(not Enter(1453, "Trade District", 0.646, 0.714), "Horde in Stormwind: no Alliance vendors")
M.faction = "Alliance"
M.mapID, M.subzone, M.pos = 1432, "Thelsamar", { 0.35, 0.43 }
M.npcName, M.npcFaction, M.merchant = "Horde Guy", "Horde", { 2512 }
M.Fire("MERCHANT_SHOW")
M.npcName, M.npcFaction = "Neutral Guy", "Neutral"
M.Fire("MERCHANT_SHOW")
local hordeGuy, neutralGuy
for _, v in ipairs(db.vendors) do
    if v.name == "Horde Guy" then hordeGuy = v elseif v.name == "Neutral Guy" then neutralGuy = v end
end
ok(hordeGuy and hordeGuy.faction == "Horde" and neutralGuy and neutralGuy.faction == nil, "learned vendors keep their faction")
local names = {}
for _, v in ipairs(ns.CurrentVendors(1432, "Thelsamar", "arrow", ns.WantedItems("arrow"))) do names[v.name] = true end
ok(not names["Horde Guy"] and names["Neutral Guy"], "Alliance skips a learned Horde vendor, keeps a neutral one")
M.npcFaction = nil
M.mapID, M.subzone, M.pos = 1453, "Trade District", { 0.646, 0.714 }

SlashCmdList.AMMOFINDER("where")
ok(table.concat(M.printed, " "):find("64.6, 71.4", 1, true), "/ammo where prints the position")

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
ok(#sliders == 3, "3 sliders, got " .. #sliders)
sliders[1]:SetValue(12.4)
ok(db.duration == 12, "duration slider snaps to 12, got " .. tostring(db.duration))
sliders[2]:SetValue(30)
ok(db.cooldown == 30, "cooldown slider")
SlashCmdList.AMMOFINDER("test")
ok(banner:IsShown() and banner.preview, "/ammo test previews")
banner.secure.scripts.PostClick(banner.secure)
ok(not banner:IsShown(), "preview button just closes")


-- Moving the banner
ns.UnlockBanner()
ok(banner:IsShown() and banner.alpha == 1 and not banner.anim.playing and banner.move:IsShown(), "unlocked banner stays up with outline")
banner.cx, banner.top = 1060, 900
banner.scripts.OnDragStart(banner)
banner.scripts.OnDragStop(banner)
ok(db.bannerX == 100 and db.bannerY == 180, ("drag saves position (%s, %s)"):format(tostring(db.bannerX), tostring(db.bannerY)))
local p = banner.points[#banner.points]
ok(p[1] == "TOP" and p[4] == 100 and p[5] == -180, "drag re-anchors by the top edge")
banner.scripts.OnMouseUp(banner, "RightButton")
ok(not ns.IsBannerUnlocked() and not banner:IsShown() and not banner.move:IsShown(), "right-click locks and hides")
SlashCmdList.AMMOFINDER("move")
ok(ns.IsBannerUnlocked(), "/ammo move unlocks")
SlashCmdList.AMMOFINDER("move")
ok(not ns.IsBannerUnlocked(), "/ammo move locks again")
SlashCmdList.AMMOFINDER("reset")
ok(db.bannerX == 0 and db.bannerY == 260, "/ammo reset")

-- Point me there: secure, sets the waypoint and marks
local function NL_JOIN(...) return table.concat({ ... }, string.char(10)) end
db.markIcon = 1
db.ammoFilter = "any"
db.cooldown = 0
local sb = banner.secure
Enter(1453, "Trade District", 0.5, 0.57)
local name = banner.vendor.name
ok(banner.sub.text:find("UI%-RaidTargetingIcon_1") ~= nil, "banner shows the marker")
ok(sb:IsShown() and sb.parent == UIParent and not banner.button:IsShown(), "secure Point me there replaces the plain one")
ok(sb.attrs.type == "macro" and sb.attrs.macrotext == NL_JOIN("/cleartarget", "/target " .. name, "/tm [exists] 1"), "macro: " .. tostring(sb.attrs.macrotext))
ok(sb.text:find("Point me there") and sb.text:find("RaidTargetingIcon_1"), "label: " .. sb.text)
local sp = sb.points[#sb.points]
ok(sp[1] == "TOP" and sp[2] == UIParent and sp[4] == 0 and sp[5] == -(260 + banner.h - 16 - 26), "secure button sits in the button row")
M.waypoint = nil
sb.scripts.PostClick(sb)
ok(M.waypoint and M.waypoint.uiMapID == 1453, "click sets the waypoint too")
ok(not banner:IsShown() and not sb:IsShown(), "click dismisses banner and button")
db.markIcon = 0
Enter(1453, "Trade District", 0.5, 0.57)
ok(sb:IsShown() and sb.attrs.type == nil and sb.text == "Point me there", "marker off: waypoint only, no macro")
SecureCmdList.TARGET_MARKER = nil
db.markIcon = 2
Enter(1453, "Trade District", 0.5, 0.57)
ok(sb.attrs.type == nil, "no macro on clients without /tm")
SecureCmdList.TARGET_MARKER = function() end
Enter(1453, "Trade District", 0.5, 0.57)
M.Fire("PLAYER_REGEN_DISABLED")
ok(not sb:IsShown() and banner.button:IsShown(), "combat start swaps to the plain button")
M.combat = true
local okHide = pcall(function() banner.anim.scripts.OnFinished() end)
ok(okHide and not banner:IsShown(), "banner can still hide in combat")
Enter(1453, "Trade District", 0.5, 0.57)
ok(banner:IsShown() and not sb:IsShown() and banner.button:IsShown(), "in combat: plain button")
M.combat = false
ns.UnlockBanner()
ok(not sb:IsShown() and banner.button:IsShown(), "move mode: plain button (locks)")
ns.LockBanner()
ns.PreviewBanner()
ok(sb:IsShown() and sb.attrs.type == nil, "preview: no macro")
M.waypoint = nil
sb.scripts.PostClick(sb)
ok(M.waypoint == nil and not banner:IsShown(), "preview click only closes")
local markButtons = Find(content, function(f) return f.kind == "Button" and f.scripts.OnClick and f.w == 22 and f.h == 22 end)
ok(#markButtons == 8, "8 marker buttons, got " .. #markButtons)
markButtons[8]:Click()
ok(db.markIcon == 8, "marker button picks skull")

-- Only announce when low
db.markIcon, db.onlyLow, db.lowAmmo, db.cooldown = 1, true, 200, 10
M.time = M.time + 3600
M.ammoCount = 520
ok(not Enter(1453, "Trade District", 0.5, 0.57), "only when low: quiet with 520 ammo")
M.ammoCount = 150
ok(Enter(1453, "Trade District", 0.5, 0.57) and banner.title.text == "Low on Ammo!", "only when low: announced at 150, timeout not used up before")
M.ammoCount = 0
M.time = M.time + 3600
ok(Enter(1453, "Trade District", 0.5, 0.57) and banner.title.text == "Out of Ammo!", "only when low: announced when out")
M.ammoCount = 520
Reset()
SlashCmdList.AMMOFINDER("check")
ok(banner:IsShown(), "/ammo check ignores only when low")
db.onlyLow = false
local onlyLow = Check("Only announce when below")
ok(onlyLow ~= nil, "only when low checkbox exists")
onlyLow:Click()
ok(db.onlyLow == true, "checkbox turns it on")
db.onlyLow = false

-- Both halves of the click: only the one matching "cast on key down" acts
db.markIcon, db.onlyLow, db.cooldown = 1, false, 0
local sb2 = banner.secure
M.keyDown = true
Enter(1453, "Trade District", 0.5, 0.57)
ok(sb2.attrs.type == "macro", "macro set")
M.waypoint = nil
sb2.scripts.PostClick(sb2, "LeftButton", false)
ok(M.waypoint == nil and sb2:IsShown(), "key down on: the up half does nothing")
M.targetName = banner.vendor.name
M.printed = {}
sb2.scripts.PostClick(sb2, "LeftButton", true)
ok(M.waypoint ~= nil and not sb2:IsShown(), "key down on: the down half acts")
ok(table.concat(M.printed, " "):find("Targeted and marked"), "reports the mark")
M.keyDown = false
Enter(1453, "Trade District", 0.5, 0.57)
M.targetName = nil
M.printed = {}
sb2.scripts.PostClick(sb2, "LeftButton", true)
ok(sb2:IsShown(), "key down off: the down half does nothing")
sb2.scripts.PostClick(sb2, "LeftButton", false)
ok(not sb2:IsShown() and table.concat(M.printed, " "):find("Couldn't target"), "reports when the vendor wasn't targeted")
M.printed = {}
local okDebug, err = pcall(SlashCmdList.AMMOFINDER, "debug")
ok(okDebug and #M.printed >= 5, "/ammo debug prints: " .. tostring(err))

-- AmmoFinder's own waypoint: arrow, minimap pin and line
local Nav = ns.Nav
db.navStyle = "own"
M.mapID, M.pos, M.facing, M.waypoint, M.printed = 1453, { 0.40, 0.50 }, 0, nil, {}
Nav.Set({ name = "East Vendor", mapID = 1453, x = 50, y = 50 }) -- 100 yards due east
ok(M.waypoint == nil and Nav.Get() and Nav.Get().name == "East Vendor", "own waypoint set, not the game's")
ok(Nav.arrow:IsShown() and Nav.arrow.dist.text == "100 yards", "arrow shows the distance: " .. tostring(Nav.arrow.dist.text))
ok(math.abs(Nav.arrow.icon.rotation + math.pi / 2) < 0.001, "facing north, east is a quarter turn clockwise: " .. tostring(Nav.arrow.icon.rotation))
M.facing = -math.pi / 2 -- facing east
Nav.Update()
ok(math.abs(Nav.arrow.icon.rotation) < 0.001, "facing east, the arrow points straight up")
local mp = Nav.miniPin
ok(mp and mp[1] > 0 and math.abs(mp[2]) < 0.001 and not mp[3], "minimap pin to the right, inside the minimap")
M.pos = { 0.10, 0.50 } -- 400 yards away: on the minimap's edge
Nav.Update()
ok(Nav.miniPin[3], "far away: pin on the minimap's edge")
db.navArrow = false
Nav.Update()
ok(not Nav.arrow:IsShown(), "arrow off in settings: hidden")
db.navArrow = true
M.continents = { [1453] = 1 }
Nav.Set({ name = "Far Vendor", mapID = 1453, x = 50, y = 50 })
M.continents = { [1453] = 1, [1429] = 0 }
M.mapID = 1429
Nav.Update()
ok(Nav.arrow.dist.text == "On another continent", "other continent: says so")
M.continents, M.mapID = nil, 1453
Nav.Set({ name = "East Vendor", mapID = 1453, x = 50, y = 50 })
M.pos = { 0.497, 0.50 }
Nav.Update()
ok(Nav.Get() == nil and not Nav.arrow:IsShown() and table.concat(M.printed, " "):find("arrived"), "arriving clears it")
-- Point me there with the own waypoint, and in combat
M.pos = { 0.5, 0.57 }
Enter(1453, "Trade District", 0.4, 0.57) -- 100 yards from the Stovers, so not arrived yet
M.combat = true
banner.button:Click()
M.combat = false
ok(Nav.Get() ~= nil and M.waypoint == nil, "Point me there in combat: own waypoint works")
ok(db.navTarget and db.navTarget.name == Nav.Get().name, "waypoint kept for a /reload")
SlashCmdList.AMMOFINDER("clear")
ok(Nav.Get() == nil and db.navTarget == nil, "/ammo clear")
db.navStyle = "game"
banner.button:Click()
Enter(1453, "Trade District", 0.5, 0.57)
banner.button:Click()
ok(M.waypoint ~= nil and Nav.Get() == nil, "game style: the game's map pin")

-- The close X
db.cooldown, db.ammoFilter, M.ranged, M.faction = 0, "any", 1000, "Alliance"
db.ammoItems = { [2512] = true, [2515] = true, [3030] = true, [11285] = true }
ok(Enter(1453, "Trade District", 0.572, 0.57) and banner.close:IsShown(), "banner has a close button")
banner.close:Click()
ok(not banner:IsShown(), "the X closes the banner")
ns.UnlockBanner()
ok(not banner.close:IsShown(), "no X while moving the banner")
ns.LockBanner()
ok(banner.close:IsShown(), "X back after locking")

-- Weapon merchants: standing next to Marda Weller, the banner still names a bowyer or general goods vendor
Enter(1453, "Trade District", 0.572, 0.57)
ok(not banner.sub.text:find("Marda Weller") and banner.sub.text:find("<"), "weapon merchant skipped, title shown: " .. banner.sub.text)
ok(not table.concat(M.printed, " "):find("Marda Weller"), "weapon merchant left out of chat too")
-- Sen'jin Village: only Trayexir (weapon merchant) sells Sharp Arrows, so then he is the one
M.faction, db.ammoFilter, db.ammoItems = "Horde", "custom", { [2515] = true }
ok(Enter(1411, "Sen'jin Village", 0.563, 0.733) and banner.sub.text:find("Trayexir"), "weapon merchant when no one else sells it")
M.faction, db.ammoFilter = "Alliance", "any"
db.ammoItems = { [2512] = true, [2515] = true, [3030] = true, [11285] = true }

-- Opening a built-in vendor's window: no ammo there means they are not announced again; their real stock is used
M.mapID, M.subzone, M.pos = 1453, "Trade District", { 0.502, 0.574 }
M.npcName, M.merchant, M.printed = "Frederick Stover", { 159 }, {}
M.Fire("MERCHANT_SHOW")
ok(db.seedStock["1453:Frederick Stover"] == false and table.concat(M.printed, " "):find("sells no arrows"), "no ammo in his window: noted")
M.npcName, M.merchant = "Lina Stover", { 2516 } -- only bullets here
M.Fire("MERCHANT_SHOW")
local names = {}
for _, v in ipairs(ns.CurrentVendors(1453, "Trade District", "arrow", ns.WantedItems("arrow"))) do names[v.name] = true end
ok(not names["Frederick Stover"] and not names["Lina Stover"] and names["Thurman Mullby"], "vendors without your ammo in their window are skipped")
M.npcName, M.merchant = nil, {}

io.write(("%d passed, %d failed" .. string.char(10)):format(passed, failed))

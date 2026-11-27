local _, ns = ...

-- Seed data: ammo vendors known without having to meet them first.
-- Generated from warcraft.wiki.gg (vendor list, what each NPC sold, NPC ids)
-- and Wowhead Classic, then checked against WoW Forever's own game data (outof.games, 1.60.1): coordinates on
-- Forever's maps (Stormwind, Redridge, Mulgore and Eastern Plaguelands were reshaped), stock and titles.
-- Keyed by uiMapID. Coordinates are map percentages (0-100).
-- Anything not listed here is learned automatically the first time you open
-- an ammo vendor's window (see MERCHANT_SHOW in AmmoFinder.lua).
--
-- subzone: in-game subzone name (matched case-insensitively), may be nil
-- ammo:    "arrow", "bullet" or "both"
-- faction: "Alliance" / "Horde"; nil = both factions (neutral towns)
-- id:      Wowhead NPC id
-- items:   the ammo items (ns.AMMO ids) they sell in WoW Forever
-- title:   their title under the name (<Bowyer>), from Wowhead Classic
-- weapons: a weapon or armor merchant who also sells some ammo. Announced only when no bowyer, gunsmith or general goods vendor
--          that sells your ammo is there

-- Vendor-sold Classic ammo, lowest tier first. level = required level (Wowhead Classic)
ns.AMMO = {
    { id = 2512, type = "arrow", level = 1, name = "Rough Arrow" },
    { id = 2515, type = "arrow", level = 10, name = "Sharp Arrow" },
    { id = 3030, type = "arrow", level = 25, name = "Razor Arrow" },
    { id = 11285, type = "arrow", level = 40, name = "Jagged Arrow" },
    { id = 2516, type = "bullet", level = 1, name = "Light Shot" },
    { id = 2519, type = "bullet", level = 10, name = "Heavy Shot" },
    { id = 3033, type = "bullet", level = 25, name = "Solid Shot" },
    { id = 11284, type = "bullet", level = 40, name = "Accurate Slugs" },
}

ns.SEED = {
    [1457] = { -- Darnassus
        { name = "Ellandrieth", subzone = "Tradesmen's Terrace", x = 64.7, y = 53, ammo = "both", faction = "Alliance", id = 4170, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
        { name = "Landria", subzone = "Tradesmen's Terrace", x = 63.3, y = 66.3, ammo = "arrow", faction = "Alliance", id = 4173, items = { 2512, 2515, 3030, 11285 }, title = "Bow Merchant" },
        { name = "Ariyell Skyshadow", subzone = "Warrior's Terrace", x = 58.8, y = 44.5, ammo = "arrow", faction = "Alliance", id = 4203, items = { 2512, 2515 }, title = "Weapon Merchant", weapons = true },
        { name = "Mydrannul", subzone = "Warrior's Terrace", x = 70.7, y = 45.4, ammo = "both", faction = "Alliance", id = 4241, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
    },
    [1455] = { -- Ironforge
        { name = "Bryllia Ironbrand", subzone = "The Commons", x = 39.2, y = 74.5, ammo = "both", faction = "Alliance", id = 5101, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods Vendor" },
        { name = "Bretta Goldfury", subzone = "The Military Ward", x = 72.2, y = 65.2, ammo = "bullet", faction = "Alliance", id = 5123, items = { 2516, 2519, 3033, 11284 }, title = "Gun Merchant" },
        { name = "Skolmin Goldfury", subzone = "The Military Ward", x = 71.8, y = 66.7, ammo = "arrow", faction = "Alliance", id = 5122, items = { 2512, 2515, 3030, 11285 }, title = "Bow Merchant" },
        { name = "Thalgus Thunderfist", subzone = "The Military Ward", x = 61.6, y = 89.4, ammo = "both", faction = "Alliance", id = 7976, items = { 2512, 2515, 3030, 2516, 2519 }, title = "Weapon Merchant", weapons = true },
    },
    [1454] = { -- Orgrimmar
        { name = "Jin'sora", subzone = "Valley of Honor", x = 78.1, y = 38.5, ammo = "arrow", faction = "Horde", id = 3410, items = { 2512, 2515, 3030, 11285 }, title = "Bow Merchant" },
        { name = "Zendo'jian", subzone = "Valley of Honor", x = 81.2, y = 18.7, ammo = "arrow", faction = "Horde", id = 3409, items = { 2512, 2515 }, title = "Weapon Vendor", weapons = true },
        { name = "Kaja", subzone = "Valley of Strength", x = 52.2, y = 62.1, ammo = "bullet", faction = "Horde", id = 3322, items = { 2516, 2519, 3033, 11284 }, title = "Guns and Ammo Merchant" },
        { name = "Trak'gen", subzone = "Valley of Strength", x = 48.1, y = 80.5, ammo = "both", faction = "Horde", id = 3313, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Merchant" },
        { name = "Asoran", subzone = "Valley of Wisdom", x = 46.1, y = 40.9, ammo = "both", faction = "Horde", id = 3350, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods Vendor" },
    },
    [1453] = { -- Stormwind City
        { name = "Thulman Flintcrag", subzone = "Dwarven District", x = 62, y = 36.6, ammo = "bullet", faction = "Alliance", id = 5510, items = { 2516, 2519 }, title = "Guns Vendor" },
        { name = "Frederick Stover", subzone = "Trade District", x = 58.4, y = 69, ammo = "arrow", faction = "Alliance", id = 1298, items = { 2512, 2515, 3030, 11285 }, title = "Bow & Arrow Merchant" },
        { name = "Lina Stover", subzone = "Trade District", x = 58.7, y = 68.7, ammo = "both", faction = "Alliance", id = 1297, items = { 2512, 2515, 3030, 2516, 2519, 3033, 11284 }, title = "Bow & Gun Merchant" },
        { name = "Marda Weller", subzone = "Trade District", x = 64.1, y = 68.4, ammo = "arrow", faction = "Alliance", id = 1287, items = { 2512, 2515, 3030 }, title = "Weapons Merchant", weapons = true },
        { name = "Thurman Mullby", subzone = "Trade District", x = 64.8, y = 72.2, ammo = "both", faction = "Alliance", id = 1285, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
    },
    [1456] = { -- Thunder Bluff
        { name = "Hogor Thunderhoof", subzone = "High Rise", x = 55.6, y = 57.1, ammo = "bullet", faction = "Horde", id = 3018, items = { 2516, 2519, 3033, 11284 }, title = "Guns Merchant" },
        { name = "Jyn Stonehoof", subzone = "Lower Rise", x = 41.4, y = 62.4, ammo = "bullet", faction = "Horde", id = 2997, items = { 2516, 2519 }, title = "Weapons Merchant", weapons = true },
        { name = "Kuruk", subzone = "Lower Rise", x = 38.9, y = 64.7, ammo = "both", faction = "Horde", id = 8362, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
        { name = "Kuna Thunderhorn", subzone = "Middle Rise", x = 47, y = 45.7, ammo = "arrow", faction = "Horde", id = 3015, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer & Fletching Goods" },
    },
    [1458] = { -- Undercity
        { name = "Eleanor Rusk", subzone = "The Trade Quarter", x = 69.2, y = 48.9, ammo = "both", faction = "Horde", id = 4555, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
        { name = "Abigail Sawyer", subzone = "The War Quarter", x = 54.7, y = 38.8, ammo = "arrow", faction = "Horde", id = 4604, items = { 2512, 2515, 3030, 11285 }, title = "Bow Merchant" },
        { name = "Benijah Fenner", subzone = "The War Quarter", x = 58.8, y = 32.8, ammo = "arrow", faction = "Horde", id = 4602, items = { 2512, 2515, 3030 }, title = "Weapon Merchant", weapons = true },
        { name = "Nicholas Atwood", subzone = "The War Quarter", x = 62.7, y = 26.8, ammo = "bullet", faction = "Horde", id = 4603, items = { 2516, 2519, 3033, 11284 }, title = "Gun Merchant" },
    },
    [1417] = { -- Arathi Highlands
        { name = "Mu'uta", subzone = "Hammerfall", x = 72.5, y = 33.4, ammo = "arrow", faction = "Horde", id = 9555, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer" },
        { name = "Graud", subzone = "Hammerfall", x = 74.1, y = 32.4, ammo = "both", faction = "Horde", id = 2820, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Vikki Lonsav", subzone = "Refuge Pointe", x = 46.5, y = 47.6, ammo = "both", faction = "Alliance", id = 2808, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    [1440] = { -- Ashenvale
        { name = "Burkrum", subzone = "Splintertree Post", x = 73.5, y = 60.3, ammo = "both", faction = "Horde", id = 6028, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033 }, title = "Heavy Armor Merchant", weapons = true },
        { name = "Haljan Oakheart", subzone = "Astranaar", x = 34.9, y = 50.9, ammo = "both", faction = "Alliance", id = 3962, items = { 2515, 3030, 2519, 3033 }, title = "General Goods" },
        { name = "Bhaldaran Ravenshade", subzone = "Silverwind Refuge", x = 50.3, y = 67.3, ammo = "arrow", faction = "Alliance", id = 3951, items = { 2512, 2515 }, title = "Bowyer" },
    },
    [1447] = { -- Azshara
        { name = "Brinna Valanaar", subzone = "Talrendis Point", x = 12, y = 78.4, ammo = "arrow", faction = "Alliance", id = 14301, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer" },
    },
    [1418] = { -- Badlands
        { name = "Grawl", subzone = "Kargath", x = 3.1, y = 45.9, ammo = "both", faction = "Horde", id = 2908, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    [1439] = { -- Darkshore
        { name = "Dalmond", subzone = "Auberdine", x = 37.5, y = 40.5, ammo = "both", faction = "Alliance", id = 4182, items = { 2512, 2515, 2516, 2519 }, title = "General Goods" },
    },
    [1443] = { -- Desolace
        { name = "Christi Galvanis", subzone = "Nijel's Point", x = 66.6, y = 7, ammo = "both", faction = "Alliance", id = 12960, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Tukk", subzone = "Shadowprey Village", x = 24.9, y = 71.8, ammo = "both", faction = "Horde", id = 12027, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods Vendor" },
        { name = "Super-Seller 680", x = 40.5, y = 79.3, ammo = "both", id = 12246, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1426] = { -- Dun Morogh
        { name = "Hegnar Rumbleshot", x = 40.7, y = 65.1, ammo = "bullet", faction = "Alliance", id = 1243, items = { 2516, 2519 }, title = "Gunsmith" },
        { name = "Adlin Pridedrift", subzone = "Coldridge Valley", x = 30.1, y = 71.5, ammo = "both", faction = "Alliance", id = 829, items = { 2512, 2516 }, title = "General Supplies" },
        { name = "Kreg Bilmn", subzone = "Thunderbrew Distillery", x = 47.2, y = 52.4, ammo = "both", faction = "Alliance", id = 1691, items = { 2512, 2516 }, title = "General Supplies" },
    },
    [1411] = { -- Durotar
        { name = "Ghrawt", subzone = "Razor Hill", x = 53, y = 41, ammo = "arrow", faction = "Horde", id = 3165, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Jark", subzone = "Razor Hill Barracks", x = 54.4, y = 42.2, ammo = "both", faction = "Horde", id = 3164, items = { 2512, 2516 }, title = "General Goods" },
        { name = "K'waii", subzone = "Sen'jin Village", x = 56.3, y = 73.4, ammo = "both", faction = "Horde", id = 3186, items = { 2512, 2516 }, title = "General Goods" },
        { name = "Trayexir", subzone = "Sen'jin Village", x = 56.5, y = 73.1, ammo = "arrow", faction = "Horde", id = 10369, items = { 2512, 2515 }, title = "Weapon Merchant", weapons = true },
        { name = "Duokna", subzone = "Valley of Trials", x = 42.6, y = 67.3, ammo = "both", faction = "Horde", id = 3158, items = { 2512, 2516 }, title = "General Goods" },
    },
    [1431] = { -- Duskwood
        { name = "Avette Fellwood", subzone = "Darkshire", x = 73, y = 44.4, ammo = "arrow", faction = "Alliance", id = 228, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer" },
        { name = "Mabel Solaj", subzone = "Scarlet Raven Tavern", x = 74.2, y = 44.8, ammo = "both", faction = "Alliance", id = 227, items = { 2515, 3030, 2519, 3033 }, title = "General Goods Vendor" },
    },
    [1445] = { -- Dustwallow Marsh
        { name = "Zanara", subzone = "Brackenwall Village", x = 35.5, y = 30.1, ammo = "arrow", faction = "Horde", id = 9552, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer" },
        { name = "Torq Ironblast", subzone = "Foothold Citadel", x = 67.5, y = 48, ammo = "bullet", faction = "Alliance", id = 4889, items = { 2516, 2519, 3033, 11284 }, title = "Gunsmith" },
        { name = "Charity Mipsy", subzone = "Theramore Isle", x = 67.5, y = 51.7, ammo = "both", faction = "Alliance", id = 4896, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Jensen Farran", subzone = "Theramore Isle", x = 68, y = 49.9, ammo = "arrow", faction = "Alliance", id = 4892, items = { 2512, 2515, 3030, 11285 }, title = "Bowyer" },
    },
    [1423] = { -- Eastern Plaguelands
        { name = "Caretaker Alen", subzone = "Light's Hope Chapel", x = 69.9, y = 53.7, ammo = "both", id = 11038, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "The Argent Dawn" },
    },
    [1429] = { -- Elwynn Forest
        { name = "Drake Lindgren", subzone = "Eastvale Logging Camp", x = 83.3, y = 66.7, ammo = "both", faction = "Alliance", id = 1250, items = { 2512, 2516 }, title = "General & Trade Supplies" },
        { name = "Rallic Finn", subzone = "Eastvale Logging Camp", x = 83.3, y = 66.1, ammo = "arrow", faction = "Alliance", id = 1198, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Brog Hamfist", subzone = "Lion's Pride Inn", x = 44, y = 65.9, ammo = "both", faction = "Alliance", id = 151, items = { 2512, 2516 }, title = "General Supplies" },
        { name = "Brother Danil", subzone = "Northshire Valley", x = 47.5, y = 41.6, ammo = "both", faction = "Alliance", id = 152, items = { 2512, 2516 }, title = "General Supplies" },
    },
    [1448] = { -- Felwood
        { name = "Bale", subzone = "Bloodvenom Post", x = 34.8, y = 53.2, ammo = "both", faction = "Horde", id = 2806, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Malygen", subzone = "Talonbranch Glade", x = 62.3, y = 25.6, ammo = "both", faction = "Alliance", id = 2803, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Gorn One Eye", subzone = "Timbermaw Hold", x = 65.2, y = 2.7, ammo = "both", id = 11555, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1444] = { -- Feralas
        { name = "Cawind Trueaim", subzone = "Camp Mojache", x = 74.9, y = 45.7, ammo = "both", faction = "Horde", id = 9548, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "Gunsmith & Bowyer" },
        { name = "Faralorn", subzone = "Feathermoon Stronghold", x = 30.7, y = 43.4, ammo = "both", faction = "Alliance", id = 7942, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Supplies" },
    },
    [1424] = { -- Hillsbrad Foothills
        { name = "Sarah Raycroft", subzone = "Southshore", x = 49.1, y = 55.1, ammo = "both", faction = "Alliance", id = 3541, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Kayren Soothallow", subzone = "Tarren Mill", x = 62.6, y = 19.9, ammo = "both", faction = "Horde", id = 2401, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    [1432] = { -- Loch Modan
        { name = "Yanni Stoutheart", subzone = "Stoutlager Inn", x = 34.8, y = 48.6, ammo = "both", faction = "Alliance", id = 1682, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Cliff Hadin", subzone = "The Farstrider Lodge", x = 83, y = 63, ammo = "arrow", faction = "Alliance", id = 1687, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Irene Sureshot", subzone = "The Farstrider Lodge", x = 83.2, y = 63.4, ammo = "bullet", faction = "Alliance", id = 1686, items = { 2516, 2519, 3033 }, title = "Gunsmith" },
        { name = "Xandar Goodbeard", subzone = "The Farstrider Lodge", x = 82.5, y = 63.4, ammo = "both", faction = "Alliance", id = 1685, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Vrok Blunderblast", subzone = "Thelsamar", x = 35.8, y = 43.5, ammo = "bullet", faction = "Alliance", id = 1469, items = { 2516, 2519 }, title = "Gunsmith" },
    },
    [1450] = { -- Moonglade
        { name = "Daeolyn Summerleaf", subzone = "Nighthaven", x = 45.2, y = 34.7, ammo = "both", id = 12021, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Narianna", subzone = "Nighthaven", x = 53.3, y = 42.7, ammo = "arrow", id = 12029, items = { 2512, 2515, 3030 }, title = "Bowyer" },
    },
    [1412] = { -- Mulgore
        { name = "Kennah Hawkseye", subzone = "Bloodhoof Village", x = 45, y = 62, ammo = "bullet", faction = "Horde", id = 3078, items = { 2516, 2519 }, title = "Gunsmith" },
        { name = "Moorat Longstride", subzone = "Bloodhoof Village", x = 45.3, y = 61.3, ammo = "both", faction = "Horde", id = 3076, items = { 2512, 2516 }, title = "General Goods" },
        { name = "Kawnie Softbreeze", subzone = "Camp Narache", x = 44.8, y = 77, ammo = "both", faction = "Horde", id = 3072, items = { 2512, 2516 }, title = "General Goods" },
    },
    [1433] = { -- Redridge Mountains
        { name = "Henry Chapal", subzone = "Lakeshire", x = 18.8, y = 41.3, ammo = "bullet", faction = "Alliance", id = 3088, items = { 2516, 2519, 3033 }, title = "Gunsmith" },
        { name = "Lindsay Ashlock", subzone = "Lakeshire", x = 23.7, y = 47.3, ammo = "both", faction = "Alliance", id = 791, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Kimberly Hiett", subzone = "Lakeshire Inn", x = 22, y = 45.6, ammo = "arrow", faction = "Alliance", id = 789, items = { 2512, 2515, 3030, 11285 }, title = "Fletcher" },
    },
    [1427] = { -- Searing Gorge
        { name = "Master Smith Burninate", subzone = "Thorium Point", x = 38.8, y = 28.5, ammo = "both", id = 14624, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "The Thorium Brotherhood" },
    },
    [1451] = { -- Silithus
        { name = "Calandrath", subzone = "Cenarion Hold", x = 51.9, y = 39.2, ammo = "both", id = 15174, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "Innkeeper" },
    },
    [1421] = { -- Silverpine Forest
        { name = "Edwin Harly", subzone = "The Sepulcher", x = 44, y = 39.9, ammo = "both", faction = "Horde", id = 2140, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Nadia Vernon", subzone = "The Sepulcher", x = 45, y = 39.3, ammo = "arrow", faction = "Horde", id = 9553, items = { 2512, 2515 }, title = "Bowyer" },
    },
    [1442] = { -- Stonetalon Mountains
        { name = "Chylina", subzone = "Stonetalon Peak", x = 35.5, y = 6.2, ammo = "both", faction = "Alliance", id = 4084, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Borand", subzone = "Sun Rock Retreat", x = 45.4, y = 59.1, ammo = "arrow", faction = "Horde", id = 9549, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Grawnal", subzone = "Sun Rock Retreat", x = 45.9, y = 58.7, ammo = "both", faction = "Horde", id = 4082, items = { 2512, 2515, 2516, 2519 }, title = "General Goods" },
    },
    [1434] = { -- Stranglethorn Vale
        { name = "Mazk Snipeshot", subzone = "Booty Bay", x = 28.5, y = 75.1, ammo = "bullet", id = 2685, items = { 2516, 2519, 3033 }, title = "Engineering Supplies" },
        { name = "Haren Kanmae", subzone = "Booty Bay", x = 28.3, y = 74.6, ammo = "arrow", id = 2839, items = { 2512, 2515, 3030, 11285 }, title = "Superior Bowyer" },
        { name = "Uthok", subzone = "Grom'gol Base Camp", x = 31.6, y = 28, ammo = "both", faction = "Horde", id = 1149, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Supplies" },
        { name = "Corporal Bluth", subzone = "Rebel Camp", x = 38, y = 3, ammo = "both", faction = "Alliance", id = 734, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "Camp Trader" },
    },
    [1446] = { -- Tanaris
        { name = "Blizrik Buckshot", subzone = "Gadgetzan", x = 50.7, y = 27.5, ammo = "bullet", id = 8131, items = { 2516, 2519, 3033, 11284 }, title = "Gunsmith" },
        { name = "Jabbey", subzone = "Steamwheedle Port", x = 67, y = 22, ammo = "both", id = 8139, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    [1438] = { -- Teldrassil
        { name = "Keina", subzone = "Aldrassil", x = 59.3, y = 41.1, ammo = "arrow", faction = "Alliance", id = 3589, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Lyrai", subzone = "Aldrassil", x = 59.5, y = 40.9, ammo = "both", faction = "Alliance", id = 3587, items = { 2512, 2516 }, title = "General Supplies" },
        { name = "Aldia", subzone = "Dolanaar", x = 55.5, y = 57.2, ammo = "both", faction = "Alliance", id = 3608, items = { 2512, 2516 }, title = "General Supplies" },
        { name = "Jeena Featherbow", subzone = "Dolanaar", x = 55.9, y = 59.2, ammo = "arrow", faction = "Alliance", id = 3610, items = { 2512, 2515 }, title = "Bowyer" },
    },
    [1413] = { -- The Barrens
        { name = "Jazzik", subzone = "Ratchet", x = 61.9, y = 38.8, ammo = "both", id = 3498, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Barg", subzone = "The Crossroads", x = 51.7, y = 30, ammo = "both", faction = "Horde", id = 3481, items = { 2512, 2515, 2516, 2519 }, title = "General Supplies" },
        { name = "Uthrok", subzone = "The Crossroads", x = 51.1, y = 29.1, ammo = "both", faction = "Horde", id = 3488, items = { 2512, 2515, 2516, 2519 }, title = "Bowyer & Gunsmith" },
    },
    [1425] = { -- The Hinterlands
        { name = "Renn'az", subzone = "Revantusk Village", x = 76.9, y = 81.4, ammo = "arrow", faction = "Horde", id = 17598, items = { 2512, 2515, 3030, 11285 }, title = "Ammunition Vendor" },
    },
    [1441] = { -- Thousand Needles
        { name = "Jawn Highmesa", subzone = "Freewind Post", x = 45.9, y = 51.5, ammo = "both", faction = "Horde", id = 4876, items = { 2515, 3030, 2519, 3033 }, title = "General Goods" },
        { name = "Starn", subzone = "Freewind Post", x = 44.9, y = 50.7, ammo = "both", faction = "Horde", id = 9551, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "Gunsmith & Bowyer" },
        { name = "Synge", subzone = "Mirage Raceway", x = 80.4, y = 77, ammo = "bullet", id = 3053, items = { 2516, 2519, 3033, 11284 }, title = "Gun Merchant" },
    },
    [1420] = { -- Tirisfal Glades
        { name = "Mrs. Winters", subzone = "Brill", x = 61.2, y = 52.6, ammo = "both", faction = "Horde", id = 2134, items = { 2512, 2516 }, title = "General Supplies" },
        { name = "Joshua Kien", subzone = "Deathknell", x = 32.3, y = 65.4, ammo = "both", faction = "Horde", id = 2115, items = { 2512, 2516 }, title = "General Supplies" },
    },
    [1449] = { -- Un'Goro Crater
        { name = "Nergal", subzone = "Marshal's Refuge", x = 43.3, y = 7.7, ammo = "both", id = 12959, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods Vendor" },
    },
    [1436] = { -- Westfall
        { name = "William MacGregor", subzone = "Sentinel Hill", x = 57.7, y = 53.9, ammo = "arrow", faction = "Alliance", id = 1668, items = { 2512, 2515 }, title = "Bowyer" },
        { name = "Quartermaster Lewis", subzone = "Sentinel Tower", x = 57, y = 47.2, ammo = "both", faction = "Alliance", id = 491, items = { 2512, 2515, 2516, 2519 }, title = "Quartermaster" },
    },
    [1437] = { -- Wetlands
        { name = "Edwina Monzor", subzone = "Menethil Harbor", x = 11.1, y = 58.3, ammo = "arrow", faction = "Alliance", id = 1462, items = { 2512, 2515, 3030, 11285 }, title = "Fletcher" },
        { name = "Gruham Rumdnul", subzone = "Menethil Harbor", x = 12.1, y = 58, ammo = "both", faction = "Alliance", id = 1452, items = { 2515, 3030, 2519, 3033 }, title = "General Supplies" },
        { name = "Murndan Derth", subzone = "Menethil Harbor", x = 11.3, y = 59.6, ammo = "bullet", faction = "Alliance", id = 1461, items = { 2516, 2519, 3033, 11284 }, title = "Gunsmith" },
        { name = "Naela Trance", subzone = "Menethil Harbor", x = 11.3, y = 58.4, ammo = "arrow", faction = "Alliance", id = 1459, items = { 2512, 2515, 3030 }, title = "Bowyer" },
        { name = "Neal Allen", subzone = "Menethil Harbor", x = 10.8, y = 56.8, ammo = "both", faction = "Alliance", id = 1448, items = { 2515, 3030, 2519, 3033 }, title = "Engineering & General Goods Supplier" },
    },
    [1452] = { -- Winterspring
        { name = "Wixxrak", subzone = "Everlook", x = 61.7, y = 38, ammo = "bullet", id = 11184, items = { 2516, 2519, 3033, 11284 }, title = "Weaponsmith & Gunsmith" },
        { name = "Natheril Raincaller", subzone = "Starfall Village", x = 51.5, y = 30.8, ammo = "both", faction = "Alliance", id = 2084, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    [1416] = { -- Alterac Mountains
        { name = "Aemara", x = 17.2, y = 71.5, ammo = "arrow", faction = "Alliance", id = 28989, items = { 2512, 2515, 3030 }, title = "Bowyer" },
    },
}

-- Vendors in the zones WoW Forever added. Their map ids are only known in game, so these are keyed by the zone's name
-- (as C_Map.GetMapInfo gives it) and looked up when you enter a map that has no ids here. From outof.games (Forever
-- game data 1.60.1). They have no subzone, so outside a city they are announced when you are close to them
ns.SEED_BY_NAME = {
    ["Mount Hyjal"] = {
        { name = "Caitir Flinthew", x = 15.7, y = 50.5, ammo = "both", faction = "Alliance", id = 258380, items = { 2512, 2516 }, title = "Innkeeper" },
        { name = "Lenedil Moonwing", x = 70.9, y = 50.8, ammo = "both", id = 43411, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Ortak Lomgok", x = 12.9, y = 52.9, ammo = "both", faction = "Horde", id = 244512, items = { 2512, 2516 }, title = "Innkeeper" },
    },
    ["Riverglades"] = {
        { name = "Fizzix Boomshot", x = 78.6, y = 53.6, ammo = "bullet", id = 260566, items = { 2516, 2519, 3033, 11284 }, title = "Gunsmith" },
        { name = "Friz Frazzlespark", x = 77.1, y = 52.9, ammo = "both", id = 255897, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "Specialty Goods" },
        { name = "Grizzek", x = 76.7, y = 53.2, ammo = "both", id = 255895, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Maka", x = 58.2, y = 45.9, ammo = "both", faction = "Horde", id = 260343, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
        { name = "Martha Wellsworth", x = 64.3, y = 84.1, ammo = "both", faction = "Alliance", id = 259860, items = { 2515, 3030, 11285, 2519, 3033, 11284 }, title = "General Goods" },
    },
    ["Zephras Isle"] = {
        { name = "Antelariaa Cloudgaze", x = 63, y = 77.8, ammo = "both", id = 252390, items = { 2512, 2515, 2516, 2519 }, title = "General Goods" },
        { name = "Tephri Thriceforged", x = 44.8, y = 44.2, ammo = "arrow", id = 257421, items = { 2512, 2515 }, title = "Tailor" },
        { name = "Uualia Suncrest", x = 42.8, y = 24.5, ammo = "both", id = 251537, items = { 2512, 2516 }, title = "General Goods" },
        { name = "Veena Vericloud", x = 44.7, y = 45.5, ammo = "both", id = 254358, items = { 2512, 2515, 2516, 2519 }, title = "General Goods" },
    },
}

-- Capital cities: announced once on entering the city (any subzone), and the
-- nearest matching vendor is the one the waypoint points at.
ns.CITY_MAPS = {
    [1453] = true, -- Stormwind City
    [1454] = true, -- Orgrimmar
    [1455] = true, -- Ironforge
    [1456] = true, -- Thunder Bluff
    [1457] = true, -- Darnassus
    [1458] = true, -- Undercity
}

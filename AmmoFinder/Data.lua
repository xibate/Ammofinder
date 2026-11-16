local _, ns = ...

-- Seed data: ammo vendors known without having to meet them first.
-- Generated from warcraft.wiki.gg (vendor list, what each NPC sold, NPC ids)
-- and Wowhead Classic (coordinates), Vanilla-era vendors only.
-- Keyed by uiMapID. Coordinates are map percentages (0-100) from Wowhead Classic.
-- Anything not listed here is learned automatically the first time you open
-- an ammo vendor's window (see MERCHANT_SHOW in AmmoFinder.lua).
--
-- subzone: in-game subzone name (matched case-insensitively), may be nil
-- ammo:    "arrow", "bullet" or "both"
-- faction: "Alliance" / "Horde"; nil = both factions (neutral towns)
-- id:      Wowhead NPC id
-- items:   the ammo items (ns.AMMO ids) they sell, from each item's "Sold by" list on Wowhead Classic

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
        { name = "Ellandrieth", subzone = "Tradesmen's Terrace", x = 64.4, y = 53, ammo = "both", faction = "Alliance", id = 4170, items = { 2512, 2515, 3030, 2516, 2519, 3033 } },
        { name = "Landria", subzone = "Tradesmen's Terrace", x = 63, y = 67.6, ammo = "arrow", faction = "Alliance", id = 4173, items = { 2512, 2515, 3030, 11285 } },
        { name = "Ariyell Skyshadow", subzone = "Warrior's Terrace", x = 58.4, y = 44.4, ammo = "arrow", faction = "Alliance", id = 4203, items = { 2512, 2515 } },
        { name = "Mydrannul", subzone = "Warrior's Terrace", x = 70, y = 44.4, ammo = "both", faction = "Alliance", id = 4241, items = { 2512, 2515, 2516, 2519 } },
    },
    [1455] = { -- Ironforge
        { name = "Bryllia Ironbrand", subzone = "The Commons", x = 39, y = 73.8, ammo = "both", faction = "Alliance", id = 5101, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Bretta Goldfury", subzone = "The Military Ward", x = 72.2, y = 65.8, ammo = "bullet", faction = "Alliance", id = 5123, items = { 2516, 2519, 3033, 11284 } },
        { name = "Skolmin Goldfury", subzone = "The Military Ward", x = 71.6, y = 66.2, ammo = "arrow", faction = "Alliance", id = 5122, items = { 2512, 2515, 3030, 11285 } },
        { name = "Thalgus Thunderfist", subzone = "The Military Ward", x = 61.2, y = 89.2, ammo = "both", faction = "Alliance", id = 7976, items = { 2512, 2515, 3030, 2516, 2519 } },
    },
    [1454] = { -- Orgrimmar
        { name = "Jin'sora", subzone = "Valley of Honor", x = 77.4, y = 38.6, ammo = "arrow", faction = "Horde", id = 3410, items = { 2512, 2515, 3030, 11285 } },
        { name = "Zendo'jian", subzone = "Valley of Honor", x = 81, y = 19.6, ammo = "arrow", faction = "Horde", id = 3409, items = { 2512, 2515 } },
        { name = "Kaja", subzone = "Valley of Strength", x = 52.2, y = 62.4, ammo = "bullet", faction = "Horde", id = 3322, items = { 2516, 2519, 3033, 11284 } },
        { name = "Trak'gen", subzone = "Valley of Strength", x = 48, y = 80.2, ammo = "both", faction = "Horde", id = 3313, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Asoran", subzone = "Valley of Wisdom", x = 46, y = 40.4, ammo = "both", faction = "Horde", id = 3350, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1453] = { -- Stormwind City
        { name = "Thulman Flintcrag", subzone = "Dwarven District", x = 54.4, y = 15.2, ammo = "bullet", faction = "Alliance", id = 5510, items = { 2516, 2519 } },
        { name = "Frederick Stover", subzone = "Trade District", x = 50.2, y = 57.4, ammo = "arrow", faction = "Alliance", id = 1298, items = { 2512, 2515, 3030, 11285 } },
        { name = "Lina Stover", subzone = "Trade District", x = 50.4, y = 57.4, ammo = "both", faction = "Alliance", id = 1297, items = { 2512, 2515, 3030, 2516, 2519, 3033, 11284 } },
        { name = "Marda Weller", subzone = "Trade District", x = 57.2, y = 57, ammo = "arrow", faction = "Alliance", id = 1287, items = { 2512, 2515, 3030 } },
        { name = "Thurman Mullby", subzone = "Trade District", x = 64.6, y = 71.4, ammo = "both", faction = "Alliance", id = 1285, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
    },
    [1456] = { -- Thunder Bluff
        { name = "Hogor Thunderhoof", subzone = "High Rise", x = 55.4, y = 56.4, ammo = "bullet", faction = "Horde", id = 3018, items = { 2516, 2519, 3033, 11284 } },
        { name = "Jyn Stonehoof", subzone = "Lower Rise", x = 41.2, y = 62, ammo = "bullet", faction = "Horde", id = 2997, items = { 2516, 2519 } },
        { name = "Kuruk", subzone = "Lower Rise", x = 39, y = 64.2, ammo = "both", faction = "Horde", id = 8362, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Kuna Thunderhorn", subzone = "Middle Rise", x = 46.4, y = 44.6, ammo = "arrow", faction = "Horde", id = 3015, items = { 2512, 2515, 3030, 11285 } },
    },
    [1458] = { -- Undercity
        { name = "Eleanor Rusk", subzone = "The Trade Quarter", x = 68.2, y = 48.8, ammo = "both", faction = "Horde", id = 4555, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Abigail Sawyer", subzone = "The War Quarter", x = 54.8, y = 38, ammo = "arrow", faction = "Horde", id = 4604, items = { 2512, 2515, 3030, 11285 } },
        { name = "Benijah Fenner", subzone = "The War Quarter", x = 58.4, y = 32.4, ammo = "arrow", faction = "Horde", id = 4602, items = { 2512, 2515, 3030 } },
        { name = "Nicholas Atwood", subzone = "The War Quarter", x = 62.2, y = 27, ammo = "bullet", faction = "Horde", id = 4603, items = { 2516, 2519, 3033, 11284 } },
    },
    [1417] = { -- Arathi Highlands
        { name = "Mu'uta", subzone = "Hammerfall", x = 72.4, y = 33.4, ammo = "arrow", faction = "Horde", id = 9555, items = { 2512, 2515, 3030, 11285 } },
        { name = "Graud", subzone = "Hammerfall", x = 74, y = 32.4, ammo = "both", faction = "Horde", id = 2820, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Vikki Lonsav", subzone = "Refuge Pointe", x = 46.4, y = 47.4, ammo = "both", faction = "Alliance", id = 2808, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1440] = { -- Ashenvale
        { name = "Haljan Oakheart", subzone = "Astranaar", x = 34.8, y = 50.8, ammo = "both", faction = "Alliance", id = 3962, items = { 2515, 3030, 2519, 3033 } },
        { name = "Bhaldaran Ravenshade", subzone = "Silverwind Refuge", x = 50.2, y = 67.2, ammo = "arrow", faction = "Alliance", id = 3951, items = { 2512, 2515 } },
    },
    [1447] = { -- Azshara
        { name = "Brinna Valanaar", subzone = "Talrendis Point", x = 12, y = 78.2, ammo = "arrow", faction = "Alliance", id = 14301, items = { 2512, 2515, 3030, 11285 } },
    },
    [1418] = { -- Badlands
        { name = "Grawl", subzone = "Kargath", x = 3, y = 46, ammo = "both", faction = "Horde", id = 2908, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1439] = { -- Darkshore
        { name = "Dalmond", subzone = "Auberdine", x = 37.4, y = 40.4, ammo = "both", faction = "Alliance", id = 4182, items = { 2512, 2515, 2516, 2519 } },
    },
    [1443] = { -- Desolace
        { name = "Christi Galvanis", subzone = "Nijel's Point", x = 66.4, y = 6.8, ammo = "both", faction = "Alliance", id = 12960, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Tukk", subzone = "Shadowprey Village", x = 25, y = 71.8, ammo = "both", faction = "Horde", id = 12027, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Super-Seller 680", x = 40.4, y = 79.2, ammo = "both", id = 12246, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1426] = { -- Dun Morogh
        { name = "Hegnar Rumbleshot", x = 40.6, y = 65, ammo = "bullet", faction = "Alliance", id = 1243, items = { 2516, 2519 } },
        { name = "Adlin Pridedrift", subzone = "Coldridge Valley", x = 30, y = 71.4, ammo = "both", faction = "Alliance", id = 829, items = { 2512, 2516 } },
        { name = "Kreg Bilmn", subzone = "Thunderbrew Distillery", x = 47.2, y = 52.4, ammo = "both", faction = "Alliance", id = 1691, items = { 2512, 2516 } },
    },
    [1411] = { -- Durotar
        { name = "Ghrawt", subzone = "Razor Hill", x = 53, y = 41, ammo = "arrow", faction = "Horde", id = 3165, items = { 2512, 2515 } },
        { name = "Jark", subzone = "Razor Hill Barracks", x = 54.2, y = 42.2, ammo = "both", faction = "Horde", id = 3164, items = { 2512, 2516 } },
        { name = "K'waii", subzone = "Sen'jin Village", x = 56.2, y = 73.4, ammo = "both", faction = "Horde", id = 3186, items = { 2512, 2516 } },
        { name = "Trayexir", subzone = "Sen'jin Village", x = 56.4, y = 73.2, ammo = "arrow", faction = "Horde", id = 10369, items = { 2512, 2515 } },
        { name = "Duokna", subzone = "Valley of Trials", x = 42.6, y = 67.4, ammo = "both", faction = "Horde", id = 3158, items = { 2512, 2516 } },
    },
    [1431] = { -- Duskwood
        { name = "Avette Fellwood", subzone = "Darkshire", x = 73, y = 44.4, ammo = "arrow", faction = "Alliance", id = 228, items = { 2512, 2515, 3030, 11285 } },
        { name = "Mabel Solaj", subzone = "Scarlet Raven Tavern", x = 74, y = 44.8, ammo = "both", faction = "Alliance", id = 227, items = { 2515, 3030, 2519, 3033 } },
    },
    [1445] = { -- Dustwallow Marsh
        { name = "Zanara", subzone = "Brackenwall Village", x = 35.4, y = 30.2, ammo = "arrow", faction = "Horde", id = 9552, items = { 2512, 2515, 3030, 11285 } },
        { name = "Torq Ironblast", subzone = "Foothold Citadel", x = 67.4, y = 48, ammo = "bullet", faction = "Alliance", id = 4889, items = { 2516, 2519, 3033, 11284 } },
        { name = "Charity Mipsy", subzone = "Theramore Isle", x = 67.4, y = 51.6, ammo = "both", faction = "Alliance", id = 4896, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Jensen Farran", subzone = "Theramore Isle", x = 67.8, y = 49.8, ammo = "arrow", faction = "Alliance", id = 4892, items = { 2512, 2515, 3030, 11285 } },
    },
    [1423] = { -- Eastern Plaguelands
        { name = "Caretaker Alen", subzone = "Light's Hope Chapel", x = 79.4, y = 63.8, ammo = "both", id = 11038, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1429] = { -- Elwynn Forest
        { name = "Drake Lindgren", subzone = "Eastvale Logging Camp", x = 83.2, y = 66.6, ammo = "both", faction = "Alliance", id = 1250, items = { 2512, 2516 } },
        { name = "Rallic Finn", subzone = "Eastvale Logging Camp", x = 83.2, y = 66, ammo = "arrow", faction = "Alliance", id = 1198, items = { 2512, 2515 } },
        { name = "Brog Hamfist", subzone = "Lion's Pride Inn", x = 43.8, y = 66, ammo = "both", faction = "Alliance", id = 151, items = { 2512, 2516 } },
        { name = "Brother Danil", subzone = "Northshire Valley", x = 47.4, y = 41.4, ammo = "both", faction = "Alliance", id = 152, items = { 2512, 2516 } },
    },
    [1448] = { -- Felwood
        { name = "Bale", subzone = "Bloodvenom Post", x = 34.8, y = 53.2, ammo = "both", faction = "Horde", id = 2806, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Malygen", subzone = "Talonbranch Glade", x = 62.2, y = 25.4, ammo = "both", faction = "Alliance", id = 2803, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Gorn One Eye", subzone = "Timbermaw Hold", x = 65.2, y = 2.6, ammo = "both", id = 11555, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1444] = { -- Feralas
        { name = "Cawind Trueaim", subzone = "Camp Mojache", x = 74.8, y = 45.6, ammo = "both", faction = "Horde", id = 9548, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Faralorn", subzone = "Feathermoon Stronghold", x = 30.6, y = 43.4, ammo = "both", faction = "Alliance", id = 7942, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
    },
    [1424] = { -- Hillsbrad Foothills
        { name = "Sarah Raycroft", subzone = "Southshore", x = 49, y = 55.2, ammo = "both", faction = "Alliance", id = 3541, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Kayren Soothallow", subzone = "Tarren Mill", x = 62.4, y = 19.8, ammo = "both", faction = "Horde", id = 2401, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1432] = { -- Loch Modan
        { name = "Yanni Stoutheart", subzone = "Stoutlager Inn", x = 34.8, y = 48.6, ammo = "both", faction = "Alliance", id = 1682, items = { 2512, 2515, 2516, 2519 } },
        { name = "Cliff Hadin", subzone = "The Farstrider Lodge", x = 83, y = 63, ammo = "arrow", faction = "Alliance", id = 1687, items = { 2512, 2515 } },
        { name = "Irene Sureshot", subzone = "The Farstrider Lodge", x = 83, y = 63.4, ammo = "bullet", faction = "Alliance", id = 1686, items = { 2516, 2519, 3033 } },
        { name = "Xandar Goodbeard", subzone = "The Farstrider Lodge", x = 82.4, y = 63.4, ammo = "both", faction = "Alliance", id = 1685, items = { 2512, 2515, 2516, 2519 } },
        { name = "Vrok Blunderblast", subzone = "Thelsamar", x = 35.2, y = 42.6, ammo = "bullet", faction = "Alliance", id = 1469, items = { 2516, 2519 } },
    },
    [1450] = { -- Moonglade
        { name = "Daeolyn Summerleaf", subzone = "Nighthaven", x = 45.2, y = 34.4, ammo = "both", id = 12021, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Narianna", subzone = "Nighthaven", x = 53.2, y = 42.6, ammo = "arrow", id = 12029, items = { 2512, 2515, 3030 } },
    },
    [1412] = { -- Mulgore
        { name = "Kennah Hawkseye", subzone = "Bloodhoof Village", x = 45.4, y = 58.4, ammo = "bullet", faction = "Horde", id = 3078, items = { 2516, 2519 } },
        { name = "Moorat Longstride", subzone = "Bloodhoof Village", x = 45.8, y = 57.6, ammo = "both", faction = "Horde", id = 3076, items = { 2512, 2516 } },
        { name = "Kawnie Softbreeze", subzone = "Camp Narache", x = 45.2, y = 76.4, ammo = "both", faction = "Horde", id = 3072, items = { 2512, 2516 } },
    },
    [1433] = { -- Redridge Mountains
        { name = "Henry Chapal", subzone = "Lakeshire", x = 23.6, y = 41.6, ammo = "bullet", faction = "Alliance", id = 3088, items = { 2516, 2519, 3033 } },
        { name = "Lindsay Ashlock", subzone = "Lakeshire", x = 28.4, y = 47.4, ammo = "both", faction = "Alliance", id = 791, items = { 2512, 2515, 2516, 2519 } },
        { name = "Kimberly Hiett", subzone = "Lakeshire Inn", x = 27, y = 45.4, ammo = "arrow", faction = "Alliance", id = 789, items = { 2512, 2515, 3030 } },
    },
    [1427] = { -- Searing Gorge
        { name = "Master Smith Burninate", subzone = "Thorium Point", x = 38.6, y = 28.4, ammo = "both", id = 14624, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1451] = { -- Silithus
        { name = "Calandrath", subzone = "Cenarion Hold", x = 51.8, y = 39, ammo = "both", id = 15174, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1421] = { -- Silverpine Forest
        { name = "Edwin Harly", subzone = "The Sepulcher", x = 44, y = 40, ammo = "both", faction = "Horde", id = 2140, items = { 2512, 2515, 2516, 2519 } },
        { name = "Nadia Vernon", subzone = "The Sepulcher", x = 45, y = 39.4, ammo = "arrow", faction = "Horde", id = 9553, items = { 2512, 2515 } },
    },
    [1442] = { -- Stonetalon Mountains
        { name = "Chylina", subzone = "Stonetalon Peak", x = 35.4, y = 6.2, ammo = "both", faction = "Alliance", id = 4084, items = { 2512, 2515, 2516, 2519 } },
        { name = "Borand", subzone = "Sun Rock Retreat", x = 45.2, y = 59.2, ammo = "arrow", faction = "Horde", id = 9549, items = { 2512, 2515 } },
        { name = "Grawnal", subzone = "Sun Rock Retreat", x = 45.8, y = 58.6, ammo = "both", faction = "Horde", id = 4082, items = { 2512, 2515, 2516, 2519 } },
    },
    [1434] = { -- Stranglethorn Vale
        { name = "Haren Kanmae", subzone = "Booty Bay", x = 28.2, y = 74.4, ammo = "arrow", id = 2839, items = { 2512, 2515, 3030, 11285 } },
        { name = "Uthok", subzone = "Grom'gol Base Camp", x = 31.4, y = 28, ammo = "both", faction = "Horde", id = 1149, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
        { name = "Corporal Bluth", subzone = "Rebel Camp", x = 38, y = 3, ammo = "both", faction = "Alliance", id = 734, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1446] = { -- Tanaris
        { name = "Blizrik Buckshot", subzone = "Gadgetzan", x = 50.8, y = 27.6, ammo = "bullet", id = 8131, items = { 2516, 2519, 3033, 11284 } },
        { name = "Jabbey", subzone = "Steamwheedle Port", x = 67, y = 22, ammo = "both", id = 8139, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1438] = { -- Teldrassil
        { name = "Keina", subzone = "Aldrassil", x = 59.4, y = 41.2, ammo = "arrow", faction = "Alliance", id = 3589, items = { 2512, 2515 } },
        { name = "Lyrai", subzone = "Aldrassil", x = 59.4, y = 41, ammo = "both", faction = "Alliance", id = 3587, items = { 2512, 2516 } },
        { name = "Aldia", subzone = "Dolanaar", x = 55.4, y = 57.2, ammo = "both", faction = "Alliance", id = 3608, items = { 2512, 2516 } },
        { name = "Jeena Featherbow", subzone = "Dolanaar", x = 55.8, y = 59.2, ammo = "arrow", faction = "Alliance", id = 3610, items = { 2512, 2515 } },
    },
    [1413] = { -- The Barrens
        { name = "Jazzik", subzone = "Ratchet", x = 61.8, y = 38.8, ammo = "both", id = 3498, items = { 2512, 2515, 2516, 2519 } },
        { name = "Barg", subzone = "The Crossroads", x = 51.6, y = 30, ammo = "both", faction = "Horde", id = 3481, items = { 2512, 2515, 2516, 2519 } },
        { name = "Uthrok", subzone = "The Crossroads", x = 51, y = 29, ammo = "both", faction = "Horde", id = 3488, items = { 2512, 2515, 2516, 2519 } },
    },
    [1425] = { -- The Hinterlands
        { name = "Renn'az", subzone = "Revantusk Village", x = 76.8, y = 81.2, ammo = "arrow", faction = "Horde", id = 17598, items = { 2512, 2515, 3030 } },
    },
    [1441] = { -- Thousand Needles
        { name = "Jawn Highmesa", subzone = "Freewind Post", x = 46, y = 51.4, ammo = "both", faction = "Horde", id = 4876, items = { 2515, 3030, 2519, 3033 } },
        { name = "Starn", subzone = "Freewind Post", x = 45, y = 50.4, ammo = "both", faction = "Horde", id = 9551, items = { 2512, 2515, 3030, 11285, 2516, 2519, 3033, 11284 } },
        { name = "Synge", subzone = "Mirage Raceway", x = 80.4, y = 76.8, ammo = "bullet", id = 3053, items = { 2516, 2519, 3033, 11284 } },
    },
    [1420] = { -- Tirisfal Glades
        { name = "Mrs. Winters", subzone = "Brill", x = 61, y = 52.4, ammo = "both", faction = "Horde", id = 2134, items = { 2512, 2516 } },
        { name = "Joshua Kien", subzone = "Deathknell", x = 32.2, y = 65.4, ammo = "both", faction = "Horde", id = 2115, items = { 2512, 2516 } },
    },
    [1449] = { -- Un'Goro Crater
        { name = "Nergal", subzone = "Marshal's Refuge", x = 43.2, y = 7.8, ammo = "both", id = 12959, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
    },
    [1436] = { -- Westfall
        { name = "William MacGregor", subzone = "Sentinel Hill", x = 57.6, y = 53.8, ammo = "arrow", faction = "Alliance", id = 1668, items = { 2512, 2515 } },
        { name = "Quartermaster Lewis", subzone = "Sentinel Tower", x = 56.8, y = 47.2, ammo = "both", faction = "Alliance", id = 491, items = { 2512, 2515, 2516, 2519 } },
    },
    [1437] = { -- Wetlands
        { name = "Edwina Monzor", subzone = "Menethil Harbor", x = 11, y = 58.4, ammo = "arrow", faction = "Alliance", id = 1462, items = { 2512, 2515, 3030 } },
        { name = "Gruham Rumdnul", subzone = "Menethil Harbor", x = 12, y = 57.8, ammo = "both", faction = "Alliance", id = 1452, items = { 2515, 3030, 2519, 3033 } },
        { name = "Murndan Derth", subzone = "Menethil Harbor", x = 11.4, y = 59.4, ammo = "bullet", faction = "Alliance", id = 1461, items = { 2516, 2519, 3033, 11284 } },
        { name = "Naela Trance", subzone = "Menethil Harbor", x = 11.2, y = 58.4, ammo = "arrow", faction = "Alliance", id = 1459, items = { 2512, 2515 } },
        { name = "Neal Allen", subzone = "Menethil Harbor", x = 10.6, y = 56.8, ammo = "both", faction = "Alliance", id = 1448, items = { 2515, 3030, 2519, 3033 } },
    },
    [1452] = { -- Winterspring
        { name = "Wixxrak", subzone = "Everlook", x = 61.6, y = 38, ammo = "bullet", id = 11184, items = { 2516, 2519, 3033, 11284 } },
        { name = "Natheril Raincaller", subzone = "Starfall Village", x = 51.4, y = 30.8, ammo = "both", faction = "Alliance", id = 2084, items = { 2515, 3030, 11285, 2519, 3033, 11284 } },
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

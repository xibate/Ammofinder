# Ammo vendors

Every ammo vendor built into AmmoFinder, from `AmmoFinder/Data.lua`: 111 vendors in 40 zones.
56 sell only to the Alliance, 41 only to the Horde, and 14 in neutral places sell to both.

- **Coords** are map coordinates (0-100) on the zone's map, the same numbers `/ammo where` prints. Most come from Wowhead Classic. WoW Forever reshaped some maps, so a few can be off.
- **Faction** is who can buy from them. AmmoFinder never announces a vendor from the other faction.
- **Arrows** and **Bullets** are the vendor ammo they stock, from Wowhead Classic. Bows and crossbows shoot arrows, guns shoot bullets. Lowest tier first: Rough Arrow (level 1), Sharp Arrow (level 10), Razor Arrow (level 25), Jagged Arrow (level 40), Light Shot (level 1), Heavy Shot (level 10), Solid Shot (level 25), Accurate Slugs (level 40).

This file is generated from `Data.lua`: change the data there, then run `npm run vendors` in `tests`.

## Zones

[Darnassus](#darnassus) · [Ironforge](#ironforge) · [Orgrimmar](#orgrimmar) · [Stormwind City](#stormwind-city) · [Thunder Bluff](#thunder-bluff) · [Undercity](#undercity) · [Arathi Highlands](#arathi-highlands) · [Ashenvale](#ashenvale) · [Azshara](#azshara) · [Badlands](#badlands) · [Darkshore](#darkshore) · [Desolace](#desolace) · [Dun Morogh](#dun-morogh) · [Durotar](#durotar) · [Duskwood](#duskwood) · [Dustwallow Marsh](#dustwallow-marsh) · [Eastern Plaguelands](#eastern-plaguelands) · [Elwynn Forest](#elwynn-forest) · [Felwood](#felwood) · [Feralas](#feralas) · [Hillsbrad Foothills](#hillsbrad-foothills) · [Loch Modan](#loch-modan) · [Moonglade](#moonglade) · [Mulgore](#mulgore) · [Redridge Mountains](#redridge-mountains) · [Searing Gorge](#searing-gorge) · [Silithus](#silithus) · [Silverpine Forest](#silverpine-forest) · [Stonetalon Mountains](#stonetalon-mountains) · [Stranglethorn Vale](#stranglethorn-vale) · [Tanaris](#tanaris) · [Teldrassil](#teldrassil) · [The Barrens](#the-barrens) · [The Hinterlands](#the-hinterlands) · [Thousand Needles](#thousand-needles) · [Tirisfal Glades](#tirisfal-glades) · [Un'Goro Crater](#ungoro-crater) · [Westfall](#westfall) · [Wetlands](#wetlands) · [Winterspring](#winterspring)

## Darnassus

Capital city. Map id 1457.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Ellandrieth](https://www.wowhead.com/classic/npc=4170) | Tradesmen's Terrace | 64.4, 53 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | Light Shot, Heavy Shot, Solid Shot |
| [Landria](https://www.wowhead.com/classic/npc=4173) | Tradesmen's Terrace | 63, 67.6 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Ariyell Skyshadow](https://www.wowhead.com/classic/npc=4203) | Warrior's Terrace | 58.4, 44.4 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Mydrannul](https://www.wowhead.com/classic/npc=4241) | Warrior's Terrace | 70, 44.4 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Ironforge

Capital city. Map id 1455.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Bryllia Ironbrand](https://www.wowhead.com/classic/npc=5101) | The Commons | 39, 73.8 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Bretta Goldfury](https://www.wowhead.com/classic/npc=5123) | The Military Ward | 72.2, 65.8 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Skolmin Goldfury](https://www.wowhead.com/classic/npc=5122) | The Military Ward | 71.6, 66.2 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Thalgus Thunderfist](https://www.wowhead.com/classic/npc=7976) | The Military Ward | 61.2, 89.2 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | Light Shot, Heavy Shot |

## Orgrimmar

Capital city. Map id 1454.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Jin'sora](https://www.wowhead.com/classic/npc=3410) | Valley of Honor | 77.4, 38.6 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Zendo'jian](https://www.wowhead.com/classic/npc=3409) | Valley of Honor | 81, 19.6 | Horde | Rough Arrow, Sharp Arrow | - |
| [Kaja](https://www.wowhead.com/classic/npc=3322) | Valley of Strength | 52.2, 62.4 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Trak'gen](https://www.wowhead.com/classic/npc=3313) | Valley of Strength | 48, 80.2 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Asoran](https://www.wowhead.com/classic/npc=3350) | Valley of Wisdom | 46, 40.4 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Stormwind City

Capital city. Map id 1453.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Thulman Flintcrag](https://www.wowhead.com/classic/npc=5510) | Dwarven District | 54.4, 15.2 | Alliance | - | Light Shot, Heavy Shot |
| [Frederick Stover](https://www.wowhead.com/classic/npc=1298) | Trade District | 50.2, 57.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Lina Stover](https://www.wowhead.com/classic/npc=1297) | Trade District | 50.4, 57.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Marda Weller](https://www.wowhead.com/classic/npc=1287) | Trade District | 57.2, 57 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Thurman Mullby](https://www.wowhead.com/classic/npc=1285) | Trade District | 64.6, 71.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Thunder Bluff

Capital city. Map id 1456.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Hogor Thunderhoof](https://www.wowhead.com/classic/npc=3018) | High Rise | 55.4, 56.4 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Jyn Stonehoof](https://www.wowhead.com/classic/npc=2997) | Lower Rise | 41.2, 62 | Horde | - | Light Shot, Heavy Shot |
| [Kuruk](https://www.wowhead.com/classic/npc=8362) | Lower Rise | 39, 64.2 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Kuna Thunderhorn](https://www.wowhead.com/classic/npc=3015) | Middle Rise | 46.4, 44.6 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Undercity

Capital city. Map id 1458.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Eleanor Rusk](https://www.wowhead.com/classic/npc=4555) | The Trade Quarter | 68.2, 48.8 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Abigail Sawyer](https://www.wowhead.com/classic/npc=4604) | The War Quarter | 54.8, 38 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Benijah Fenner](https://www.wowhead.com/classic/npc=4602) | The War Quarter | 58.4, 32.4 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Nicholas Atwood](https://www.wowhead.com/classic/npc=4603) | The War Quarter | 62.2, 27 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Arathi Highlands

Map id 1417.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Graud](https://www.wowhead.com/classic/npc=2820) | Hammerfall | 74, 32.4 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Mu'uta](https://www.wowhead.com/classic/npc=9555) | Hammerfall | 72.4, 33.4 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Vikki Lonsav](https://www.wowhead.com/classic/npc=2808) | Refuge Pointe | 46.4, 47.4 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Ashenvale

Map id 1440.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Haljan Oakheart](https://www.wowhead.com/classic/npc=3962) | Astranaar | 34.8, 50.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Bhaldaran Ravenshade](https://www.wowhead.com/classic/npc=3951) | Silverwind Refuge | 50.2, 67.2 | Alliance | Rough Arrow, Sharp Arrow | - |

## Azshara

Map id 1447.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Brinna Valanaar](https://www.wowhead.com/classic/npc=14301) | Talrendis Point | 12, 78.2 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Badlands

Map id 1418.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Grawl](https://www.wowhead.com/classic/npc=2908) | Kargath | 3, 46 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Darkshore

Map id 1439.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Dalmond](https://www.wowhead.com/classic/npc=4182) | Auberdine | 37.4, 40.4 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Desolace

Map id 1443.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Super-Seller 680](https://www.wowhead.com/classic/npc=12246) | - | 40.4, 79.2 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Christi Galvanis](https://www.wowhead.com/classic/npc=12960) | Nijel's Point | 66.4, 6.8 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Tukk](https://www.wowhead.com/classic/npc=12027) | Shadowprey Village | 25, 71.8 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Dun Morogh

Map id 1426.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Hegnar Rumbleshot](https://www.wowhead.com/classic/npc=1243) | - | 40.6, 65 | Alliance | - | Light Shot, Heavy Shot |
| [Adlin Pridedrift](https://www.wowhead.com/classic/npc=829) | Coldridge Valley | 30, 71.4 | Alliance | Rough Arrow | Light Shot |
| [Kreg Bilmn](https://www.wowhead.com/classic/npc=1691) | Thunderbrew Distillery | 47.2, 52.4 | Alliance | Rough Arrow | Light Shot |

## Durotar

Map id 1411.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Ghrawt](https://www.wowhead.com/classic/npc=3165) | Razor Hill | 53, 41 | Horde | Rough Arrow, Sharp Arrow | - |
| [Jark](https://www.wowhead.com/classic/npc=3164) | Razor Hill Barracks | 54.2, 42.2 | Horde | Rough Arrow | Light Shot |
| [K'waii](https://www.wowhead.com/classic/npc=3186) | Sen'jin Village | 56.2, 73.4 | Horde | Rough Arrow | Light Shot |
| [Trayexir](https://www.wowhead.com/classic/npc=10369) | Sen'jin Village | 56.4, 73.2 | Horde | Rough Arrow, Sharp Arrow | - |
| [Duokna](https://www.wowhead.com/classic/npc=3158) | Valley of Trials | 42.6, 67.4 | Horde | Rough Arrow | Light Shot |

## Duskwood

Map id 1431.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Avette Fellwood](https://www.wowhead.com/classic/npc=228) | Darkshire | 73, 44.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Mabel Solaj](https://www.wowhead.com/classic/npc=227) | Scarlet Raven Tavern | 74, 44.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |

## Dustwallow Marsh

Map id 1445.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Zanara](https://www.wowhead.com/classic/npc=9552) | Brackenwall Village | 35.4, 30.2 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Torq Ironblast](https://www.wowhead.com/classic/npc=4889) | Foothold Citadel | 67.4, 48 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Charity Mipsy](https://www.wowhead.com/classic/npc=4896) | Theramore Isle | 67.4, 51.6 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Jensen Farran](https://www.wowhead.com/classic/npc=4892) | Theramore Isle | 67.8, 49.8 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Eastern Plaguelands

Map id 1423.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Caretaker Alen](https://www.wowhead.com/classic/npc=11038) | Light's Hope Chapel | 79.4, 63.8 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Elwynn Forest

Map id 1429.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Drake Lindgren](https://www.wowhead.com/classic/npc=1250) | Eastvale Logging Camp | 83.2, 66.6 | Alliance | Rough Arrow | Light Shot |
| [Rallic Finn](https://www.wowhead.com/classic/npc=1198) | Eastvale Logging Camp | 83.2, 66 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Brog Hamfist](https://www.wowhead.com/classic/npc=151) | Lion's Pride Inn | 43.8, 66 | Alliance | Rough Arrow | Light Shot |
| [Brother Danil](https://www.wowhead.com/classic/npc=152) | Northshire Valley | 47.4, 41.4 | Alliance | Rough Arrow | Light Shot |

## Felwood

Map id 1448.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Bale](https://www.wowhead.com/classic/npc=2806) | Bloodvenom Post | 34.8, 53.2 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Malygen](https://www.wowhead.com/classic/npc=2803) | Talonbranch Glade | 62.2, 25.4 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Gorn One Eye](https://www.wowhead.com/classic/npc=11555) | Timbermaw Hold | 65.2, 2.6 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Feralas

Map id 1444.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Cawind Trueaim](https://www.wowhead.com/classic/npc=9548) | Camp Mojache | 74.8, 45.6 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Faralorn](https://www.wowhead.com/classic/npc=7942) | Feathermoon Stronghold | 30.6, 43.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Hillsbrad Foothills

Map id 1424.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Sarah Raycroft](https://www.wowhead.com/classic/npc=3541) | Southshore | 49, 55.2 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Kayren Soothallow](https://www.wowhead.com/classic/npc=2401) | Tarren Mill | 62.4, 19.8 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Loch Modan

Map id 1432.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Yanni Stoutheart](https://www.wowhead.com/classic/npc=1682) | Stoutlager Inn | 34.8, 48.6 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Cliff Hadin](https://www.wowhead.com/classic/npc=1687) | The Farstrider Lodge | 83, 63 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Irene Sureshot](https://www.wowhead.com/classic/npc=1686) | The Farstrider Lodge | 83, 63.4 | Alliance | - | Light Shot, Heavy Shot, Solid Shot |
| [Xandar Goodbeard](https://www.wowhead.com/classic/npc=1685) | The Farstrider Lodge | 82.4, 63.4 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Vrok Blunderblast](https://www.wowhead.com/classic/npc=1469) | Thelsamar | 35.2, 42.6 | Alliance | - | Light Shot, Heavy Shot |

## Moonglade

Map id 1450.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Daeolyn Summerleaf](https://www.wowhead.com/classic/npc=12021) | Nighthaven | 45.2, 34.4 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Narianna](https://www.wowhead.com/classic/npc=12029) | Nighthaven | 53.2, 42.6 | Both (neutral) | Rough Arrow, Sharp Arrow, Razor Arrow | - |

## Mulgore

Map id 1412.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Kennah Hawkseye](https://www.wowhead.com/classic/npc=3078) | Bloodhoof Village | 45.4, 58.4 | Horde | - | Light Shot, Heavy Shot |
| [Moorat Longstride](https://www.wowhead.com/classic/npc=3076) | Bloodhoof Village | 45.8, 57.6 | Horde | Rough Arrow | Light Shot |
| [Kawnie Softbreeze](https://www.wowhead.com/classic/npc=3072) | Camp Narache | 45.2, 76.4 | Horde | Rough Arrow | Light Shot |

## Redridge Mountains

Map id 1433.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Henry Chapal](https://www.wowhead.com/classic/npc=3088) | Lakeshire | 23.6, 41.6 | Alliance | - | Light Shot, Heavy Shot, Solid Shot |
| [Lindsay Ashlock](https://www.wowhead.com/classic/npc=791) | Lakeshire | 28.4, 47.4 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Kimberly Hiett](https://www.wowhead.com/classic/npc=789) | Lakeshire Inn | 27, 45.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |

## Searing Gorge

Map id 1427.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Master Smith Burninate](https://www.wowhead.com/classic/npc=14624) | Thorium Point | 38.6, 28.4 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Silithus

Map id 1451.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Calandrath](https://www.wowhead.com/classic/npc=15174) | Cenarion Hold | 51.8, 39 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Silverpine Forest

Map id 1421.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Edwin Harly](https://www.wowhead.com/classic/npc=2140) | The Sepulcher | 44, 40 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Nadia Vernon](https://www.wowhead.com/classic/npc=9553) | The Sepulcher | 45, 39.4 | Horde | Rough Arrow, Sharp Arrow | - |

## Stonetalon Mountains

Map id 1442.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Chylina](https://www.wowhead.com/classic/npc=4084) | Stonetalon Peak | 35.4, 6.2 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Borand](https://www.wowhead.com/classic/npc=9549) | Sun Rock Retreat | 45.2, 59.2 | Horde | Rough Arrow, Sharp Arrow | - |
| [Grawnal](https://www.wowhead.com/classic/npc=4082) | Sun Rock Retreat | 45.8, 58.6 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Stranglethorn Vale

Map id 1434.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Haren Kanmae](https://www.wowhead.com/classic/npc=2839) | Booty Bay | 28.2, 74.4 | Both (neutral) | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Uthok](https://www.wowhead.com/classic/npc=1149) | Grom'gol Base Camp | 31.4, 28 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Corporal Bluth](https://www.wowhead.com/classic/npc=734) | Rebel Camp | 38, 3 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Tanaris

Map id 1446.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Blizrik Buckshot](https://www.wowhead.com/classic/npc=8131) | Gadgetzan | 50.8, 27.6 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Jabbey](https://www.wowhead.com/classic/npc=8139) | Steamwheedle Port | 67, 22 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Teldrassil

Map id 1438.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Keina](https://www.wowhead.com/classic/npc=3589) | Aldrassil | 59.4, 41.2 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Lyrai](https://www.wowhead.com/classic/npc=3587) | Aldrassil | 59.4, 41 | Alliance | Rough Arrow | Light Shot |
| [Aldia](https://www.wowhead.com/classic/npc=3608) | Dolanaar | 55.4, 57.2 | Alliance | Rough Arrow | Light Shot |
| [Jeena Featherbow](https://www.wowhead.com/classic/npc=3610) | Dolanaar | 55.8, 59.2 | Alliance | Rough Arrow, Sharp Arrow | - |

## The Barrens

Map id 1413.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Jazzik](https://www.wowhead.com/classic/npc=3498) | Ratchet | 61.8, 38.8 | Both (neutral) | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Barg](https://www.wowhead.com/classic/npc=3481) | The Crossroads | 51.6, 30 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Uthrok](https://www.wowhead.com/classic/npc=3488) | The Crossroads | 51, 29 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## The Hinterlands

Map id 1425.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Renn'az](https://www.wowhead.com/classic/npc=17598) | Revantusk Village | 76.8, 81.2 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow | - |

## Thousand Needles

Map id 1441.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Jawn Highmesa](https://www.wowhead.com/classic/npc=4876) | Freewind Post | 46, 51.4 | Horde | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Starn](https://www.wowhead.com/classic/npc=9551) | Freewind Post | 45, 50.4 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Synge](https://www.wowhead.com/classic/npc=3053) | Mirage Raceway | 80.4, 76.8 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Tirisfal Glades

Map id 1420.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Mrs. Winters](https://www.wowhead.com/classic/npc=2134) | Brill | 61, 52.4 | Horde | Rough Arrow | Light Shot |
| [Joshua Kien](https://www.wowhead.com/classic/npc=2115) | Deathknell | 32.2, 65.4 | Horde | Rough Arrow | Light Shot |

## Un'Goro Crater

Map id 1449.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Nergal](https://www.wowhead.com/classic/npc=12959) | Marshal's Refuge | 43.2, 7.8 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Westfall

Map id 1436.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [William MacGregor](https://www.wowhead.com/classic/npc=1668) | Sentinel Hill | 57.6, 53.8 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Quartermaster Lewis](https://www.wowhead.com/classic/npc=491) | Sentinel Tower | 56.8, 47.2 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Wetlands

Map id 1437.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Edwina Monzor](https://www.wowhead.com/classic/npc=1462) | Menethil Harbor | 11, 58.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Gruham Rumdnul](https://www.wowhead.com/classic/npc=1452) | Menethil Harbor | 12, 57.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Murndan Derth](https://www.wowhead.com/classic/npc=1461) | Menethil Harbor | 11.4, 59.4 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Naela Trance](https://www.wowhead.com/classic/npc=1459) | Menethil Harbor | 11.2, 58.4 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Neal Allen](https://www.wowhead.com/classic/npc=1448) | Menethil Harbor | 10.6, 56.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |

## Winterspring

Map id 1452.

| Vendor | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- |
| [Wixxrak](https://www.wowhead.com/classic/npc=11184) | Everlook | 61.6, 38 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Natheril Raincaller](https://www.wowhead.com/classic/npc=2084) | Starfall Village | 51.4, 30.8 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |


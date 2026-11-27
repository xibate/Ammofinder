# Ammo vendors

Every ammo vendor built into AmmoFinder, from `AmmoFinder/Data.lua`: 126 vendors in 44 zones.
59 sell only to the Alliance, 44 only to the Horde, and 23 in neutral places sell to both.

- **Coords** are map coordinates (0-100) on the zone's map, the same numbers `/ammo where` prints. They come from WoW Forever's own game data (outof.games, 1.60.1), so they fit Forever's reshaped maps too.
- **Title** is what they are called under their name. Weapon merchants also sell some ammo, but AmmoFinder only sends you to one when no bowyer, gunsmith or general goods vendor there sells what you want.
- **Faction** is who can buy from them. AmmoFinder never announces a vendor from the other faction.
- **Arrows** and **Bullets** are the vendor ammo they stock in WoW Forever. Bows and crossbows shoot arrows, guns shoot bullets. Lowest tier first: Rough Arrow (level 1), Sharp Arrow (level 10), Razor Arrow (level 25), Jagged Arrow (level 40), Light Shot (level 1), Heavy Shot (level 10), Solid Shot (level 25), Accurate Slugs (level 40).

This file is generated from `Data.lua`: change the data there, then run `npm run vendors` in `tests`.

## Zones

[Darnassus](#darnassus) · [Ironforge](#ironforge) · [Orgrimmar](#orgrimmar) · [Stormwind City](#stormwind-city) · [Thunder Bluff](#thunder-bluff) · [Undercity](#undercity) · [Alterac Mountains](#alterac-mountains) · [Arathi Highlands](#arathi-highlands) · [Ashenvale](#ashenvale) · [Azshara](#azshara) · [Badlands](#badlands) · [Darkshore](#darkshore) · [Desolace](#desolace) · [Dun Morogh](#dun-morogh) · [Durotar](#durotar) · [Duskwood](#duskwood) · [Dustwallow Marsh](#dustwallow-marsh) · [Eastern Plaguelands](#eastern-plaguelands) · [Elwynn Forest](#elwynn-forest) · [Felwood](#felwood) · [Feralas](#feralas) · [Hillsbrad Foothills](#hillsbrad-foothills) · [Loch Modan](#loch-modan) · [Moonglade](#moonglade) · [Mount Hyjal](#mount-hyjal) · [Mulgore](#mulgore) · [Redridge Mountains](#redridge-mountains) · [Riverglades](#riverglades) · [Searing Gorge](#searing-gorge) · [Silithus](#silithus) · [Silverpine Forest](#silverpine-forest) · [Stonetalon Mountains](#stonetalon-mountains) · [Stranglethorn Vale](#stranglethorn-vale) · [Tanaris](#tanaris) · [Teldrassil](#teldrassil) · [The Barrens](#the-barrens) · [The Hinterlands](#the-hinterlands) · [Thousand Needles](#thousand-needles) · [Tirisfal Glades](#tirisfal-glades) · [Un'Goro Crater](#ungoro-crater) · [Westfall](#westfall) · [Wetlands](#wetlands) · [Winterspring](#winterspring) · [Zephras Isle](#zephras-isle)

## Darnassus

Capital city. Map id 1457.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Ellandrieth](https://outof.games/realms/forever/npc/4170/) | General Goods Vendor | Tradesmen's Terrace | 64.7, 53 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Landria](https://outof.games/realms/forever/npc/4173/) | Bow Merchant | Tradesmen's Terrace | 63.3, 66.3 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Ariyell Skyshadow](https://outof.games/realms/forever/npc/4203/) | Weapon Merchant | Warrior's Terrace | 58.8, 44.5 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Mydrannul](https://outof.games/realms/forever/npc/4241/) | General Goods Vendor | Warrior's Terrace | 70.7, 45.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Ironforge

Capital city. Map id 1455.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Bryllia Ironbrand](https://outof.games/realms/forever/npc/5101/) | General Goods Vendor | The Commons | 39.2, 74.5 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Bretta Goldfury](https://outof.games/realms/forever/npc/5123/) | Gun Merchant | The Military Ward | 72.2, 65.2 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Skolmin Goldfury](https://outof.games/realms/forever/npc/5122/) | Bow Merchant | The Military Ward | 71.8, 66.7 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Thalgus Thunderfist](https://outof.games/realms/forever/npc/7976/) | Weapon Merchant | The Military Ward | 61.6, 89.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | Light Shot, Heavy Shot |

## Orgrimmar

Capital city. Map id 1454.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Jin'sora](https://outof.games/realms/forever/npc/3410/) | Bow Merchant | Valley of Honor | 78.1, 38.5 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Zendo'jian](https://outof.games/realms/forever/npc/3409/) | Weapon Vendor | Valley of Honor | 81.2, 18.7 | Horde | Rough Arrow, Sharp Arrow | - |
| [Kaja](https://outof.games/realms/forever/npc/3322/) | Guns and Ammo Merchant | Valley of Strength | 52.2, 62.1 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Trak'gen](https://outof.games/realms/forever/npc/3313/) | General Goods Merchant | Valley of Strength | 48.1, 80.5 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Asoran](https://outof.games/realms/forever/npc/3350/) | General Goods Vendor | Valley of Wisdom | 46.1, 40.9 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Stormwind City

Capital city. Map id 1453.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Thulman Flintcrag](https://outof.games/realms/forever/npc/5510/) | Guns Vendor | Dwarven District | 62, 36.6 | Alliance | - | Light Shot, Heavy Shot |
| [Frederick Stover](https://outof.games/realms/forever/npc/1298/) | Bow & Arrow Merchant | Trade District | 58.4, 69 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Lina Stover](https://outof.games/realms/forever/npc/1297/) | Bow & Gun Merchant | Trade District | 58.7, 68.7 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Marda Weller](https://outof.games/realms/forever/npc/1287/) | Weapons Merchant | Trade District | 64.1, 68.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Thurman Mullby](https://outof.games/realms/forever/npc/1285/) | General Goods Vendor | Trade District | 64.8, 72.2 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Thunder Bluff

Capital city. Map id 1456.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Hogor Thunderhoof](https://outof.games/realms/forever/npc/3018/) | Guns Merchant | High Rise | 55.6, 57.1 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Jyn Stonehoof](https://outof.games/realms/forever/npc/2997/) | Weapons Merchant | Lower Rise | 41.4, 62.4 | Horde | - | Light Shot, Heavy Shot |
| [Kuruk](https://outof.games/realms/forever/npc/8362/) | General Goods Vendor | Lower Rise | 38.9, 64.7 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Kuna Thunderhorn](https://outof.games/realms/forever/npc/3015/) | Bowyer & Fletching Goods | Middle Rise | 47, 45.7 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Undercity

Capital city. Map id 1458.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Eleanor Rusk](https://outof.games/realms/forever/npc/4555/) | General Goods Vendor | The Trade Quarter | 69.2, 48.9 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Abigail Sawyer](https://outof.games/realms/forever/npc/4604/) | Bow Merchant | The War Quarter | 54.7, 38.8 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Benijah Fenner](https://outof.games/realms/forever/npc/4602/) | Weapon Merchant | The War Quarter | 58.8, 32.8 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Nicholas Atwood](https://outof.games/realms/forever/npc/4603/) | Gun Merchant | The War Quarter | 62.7, 26.8 | Horde | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Alterac Mountains

Map id 1416.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Aemara](https://outof.games/realms/forever/npc/28989/) | Bowyer | - | 17.2, 71.5 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |

## Arathi Highlands

Map id 1417.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Graud](https://outof.games/realms/forever/npc/2820/) | General Goods | Hammerfall | 74.1, 32.4 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Mu'uta](https://outof.games/realms/forever/npc/9555/) | Bowyer | Hammerfall | 72.5, 33.4 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Vikki Lonsav](https://outof.games/realms/forever/npc/2808/) | General Goods | Refuge Pointe | 46.5, 47.6 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Ashenvale

Map id 1440.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Haljan Oakheart](https://outof.games/realms/forever/npc/3962/) | General Goods | Astranaar | 34.9, 50.9 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Bhaldaran Ravenshade](https://outof.games/realms/forever/npc/3951/) | Bowyer | Silverwind Refuge | 50.3, 67.3 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Burkrum](https://outof.games/realms/forever/npc/6028/) | Heavy Armor Merchant | Splintertree Post | 73.5, 60.3 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot |

## Azshara

Map id 1447.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Brinna Valanaar](https://outof.games/realms/forever/npc/14301/) | Bowyer | Talrendis Point | 12, 78.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Badlands

Map id 1418.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Grawl](https://outof.games/realms/forever/npc/2908/) | General Goods | Kargath | 3.1, 45.9 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Darkshore

Map id 1439.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Dalmond](https://outof.games/realms/forever/npc/4182/) | General Goods | Auberdine | 37.5, 40.5 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Desolace

Map id 1443.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Super-Seller 680](https://outof.games/realms/forever/npc/12246/) | - | - | 40.5, 79.3 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Christi Galvanis](https://outof.games/realms/forever/npc/12960/) | General Goods | Nijel's Point | 66.6, 7 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Tukk](https://outof.games/realms/forever/npc/12027/) | General Goods Vendor | Shadowprey Village | 24.9, 71.8 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Dun Morogh

Map id 1426.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Hegnar Rumbleshot](https://outof.games/realms/forever/npc/1243/) | Gunsmith | - | 40.7, 65.1 | Alliance | - | Light Shot, Heavy Shot |
| [Adlin Pridedrift](https://outof.games/realms/forever/npc/829/) | General Supplies | Coldridge Valley | 30.1, 71.5 | Alliance | Rough Arrow | Light Shot |
| [Kreg Bilmn](https://outof.games/realms/forever/npc/1691/) | General Supplies | Thunderbrew Distillery | 47.2, 52.4 | Alliance | Rough Arrow | Light Shot |

## Durotar

Map id 1411.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Ghrawt](https://outof.games/realms/forever/npc/3165/) | Bowyer | Razor Hill | 53, 41 | Horde | Rough Arrow, Sharp Arrow | - |
| [Jark](https://outof.games/realms/forever/npc/3164/) | General Goods | Razor Hill Barracks | 54.4, 42.2 | Horde | Rough Arrow | Light Shot |
| [K'waii](https://outof.games/realms/forever/npc/3186/) | General Goods | Sen'jin Village | 56.3, 73.4 | Horde | Rough Arrow | Light Shot |
| [Trayexir](https://outof.games/realms/forever/npc/10369/) | Weapon Merchant | Sen'jin Village | 56.5, 73.1 | Horde | Rough Arrow, Sharp Arrow | - |
| [Duokna](https://outof.games/realms/forever/npc/3158/) | General Goods | Valley of Trials | 42.6, 67.3 | Horde | Rough Arrow | Light Shot |

## Duskwood

Map id 1431.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Avette Fellwood](https://outof.games/realms/forever/npc/228/) | Bowyer | Darkshire | 73, 44.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Mabel Solaj](https://outof.games/realms/forever/npc/227/) | General Goods Vendor | Scarlet Raven Tavern | 74.2, 44.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |

## Dustwallow Marsh

Map id 1445.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Zanara](https://outof.games/realms/forever/npc/9552/) | Bowyer | Brackenwall Village | 35.5, 30.1 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Torq Ironblast](https://outof.games/realms/forever/npc/4889/) | Gunsmith | Foothold Citadel | 67.5, 48 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Charity Mipsy](https://outof.games/realms/forever/npc/4896/) | General Goods | Theramore Isle | 67.5, 51.7 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Jensen Farran](https://outof.games/realms/forever/npc/4892/) | Bowyer | Theramore Isle | 68, 49.9 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Eastern Plaguelands

Map id 1423.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Caretaker Alen](https://outof.games/realms/forever/npc/11038/) | The Argent Dawn | Light's Hope Chapel | 69.9, 53.7 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Elwynn Forest

Map id 1429.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Drake Lindgren](https://outof.games/realms/forever/npc/1250/) | General & Trade Supplies | Eastvale Logging Camp | 83.3, 66.7 | Alliance | Rough Arrow | Light Shot |
| [Rallic Finn](https://outof.games/realms/forever/npc/1198/) | Bowyer | Eastvale Logging Camp | 83.3, 66.1 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Brog Hamfist](https://outof.games/realms/forever/npc/151/) | General Supplies | Lion's Pride Inn | 44, 65.9 | Alliance | Rough Arrow | Light Shot |
| [Brother Danil](https://outof.games/realms/forever/npc/152/) | General Supplies | Northshire Valley | 47.5, 41.6 | Alliance | Rough Arrow | Light Shot |

## Felwood

Map id 1448.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Bale](https://outof.games/realms/forever/npc/2806/) | General Goods | Bloodvenom Post | 34.8, 53.2 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Malygen](https://outof.games/realms/forever/npc/2803/) | General Goods | Talonbranch Glade | 62.3, 25.6 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Gorn One Eye](https://outof.games/realms/forever/npc/11555/) | - | Timbermaw Hold | 65.2, 2.7 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Feralas

Map id 1444.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Cawind Trueaim](https://outof.games/realms/forever/npc/9548/) | Gunsmith & Bowyer | Camp Mojache | 74.9, 45.7 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Faralorn](https://outof.games/realms/forever/npc/7942/) | General Supplies | Feathermoon Stronghold | 30.7, 43.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Hillsbrad Foothills

Map id 1424.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Sarah Raycroft](https://outof.games/realms/forever/npc/3541/) | General Goods | Southshore | 49.1, 55.1 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Kayren Soothallow](https://outof.games/realms/forever/npc/2401/) | General Goods | Tarren Mill | 62.6, 19.9 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Loch Modan

Map id 1432.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Yanni Stoutheart](https://outof.games/realms/forever/npc/1682/) | General Supplies | Stoutlager Inn | 34.8, 48.6 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Cliff Hadin](https://outof.games/realms/forever/npc/1687/) | Bowyer | The Farstrider Lodge | 83, 63 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Irene Sureshot](https://outof.games/realms/forever/npc/1686/) | Gunsmith | The Farstrider Lodge | 83.2, 63.4 | Alliance | - | Light Shot, Heavy Shot, Solid Shot |
| [Xandar Goodbeard](https://outof.games/realms/forever/npc/1685/) | General Supplies | The Farstrider Lodge | 82.5, 63.4 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Vrok Blunderblast](https://outof.games/realms/forever/npc/1469/) | Gunsmith | Thelsamar | 35.8, 43.5 | Alliance | - | Light Shot, Heavy Shot |

## Moonglade

Map id 1450.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Daeolyn Summerleaf](https://outof.games/realms/forever/npc/12021/) | General Goods | Nighthaven | 45.2, 34.7 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Narianna](https://outof.games/realms/forever/npc/12029/) | Bowyer | Nighthaven | 53.3, 42.7 | Both (neutral) | Rough Arrow, Sharp Arrow, Razor Arrow | - |

## Mount Hyjal

New in WoW Forever. AmmoFinder finds it in game by the zone's name.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Caitir Flinthew](https://outof.games/realms/forever/npc/258380/) | Innkeeper | - | 15.7, 50.5 | Alliance | Rough Arrow | Light Shot |
| [Lenedil Moonwing](https://outof.games/realms/forever/npc/43411/) | General Goods | - | 70.9, 50.8 | Both (neutral) | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Ortak Lomgok](https://outof.games/realms/forever/npc/244512/) | Innkeeper | - | 12.9, 52.9 | Horde | Rough Arrow | Light Shot |

## Mulgore

Map id 1412.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Kennah Hawkseye](https://outof.games/realms/forever/npc/3078/) | Gunsmith | Bloodhoof Village | 45, 62 | Horde | - | Light Shot, Heavy Shot |
| [Moorat Longstride](https://outof.games/realms/forever/npc/3076/) | General Goods | Bloodhoof Village | 45.3, 61.3 | Horde | Rough Arrow | Light Shot |
| [Kawnie Softbreeze](https://outof.games/realms/forever/npc/3072/) | General Goods | Camp Narache | 44.8, 77 | Horde | Rough Arrow | Light Shot |

## Redridge Mountains

Map id 1433.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Henry Chapal](https://outof.games/realms/forever/npc/3088/) | Gunsmith | Lakeshire | 18.8, 41.3 | Alliance | - | Light Shot, Heavy Shot, Solid Shot |
| [Lindsay Ashlock](https://outof.games/realms/forever/npc/791/) | General Supplies | Lakeshire | 23.7, 47.3 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Kimberly Hiett](https://outof.games/realms/forever/npc/789/) | Fletcher | Lakeshire Inn | 22, 45.6 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Riverglades

New in WoW Forever. AmmoFinder finds it in game by the zone's name.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Fizzix Boomshot](https://outof.games/realms/forever/npc/260566/) | Gunsmith | - | 78.6, 53.6 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Friz Frazzlespark](https://outof.games/realms/forever/npc/255897/) | Specialty Goods | - | 77.1, 52.9 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Grizzek](https://outof.games/realms/forever/npc/255895/) | General Goods | - | 76.7, 53.2 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Maka](https://outof.games/realms/forever/npc/260343/) | General Goods | - | 58.2, 45.9 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Martha Wellsworth](https://outof.games/realms/forever/npc/259860/) | General Goods | - | 64.3, 84.1 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Searing Gorge

Map id 1427.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Master Smith Burninate](https://outof.games/realms/forever/npc/14624/) | The Thorium Brotherhood | Thorium Point | 38.8, 28.5 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Silithus

Map id 1451.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Calandrath](https://outof.games/realms/forever/npc/15174/) | Innkeeper | Cenarion Hold | 51.9, 39.2 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Silverpine Forest

Map id 1421.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Edwin Harly](https://outof.games/realms/forever/npc/2140/) | General Supplies | The Sepulcher | 44, 39.9 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Nadia Vernon](https://outof.games/realms/forever/npc/9553/) | Bowyer | The Sepulcher | 45, 39.3 | Horde | Rough Arrow, Sharp Arrow | - |

## Stonetalon Mountains

Map id 1442.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Chylina](https://outof.games/realms/forever/npc/4084/) | General Supplies | Stonetalon Peak | 35.5, 6.2 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Borand](https://outof.games/realms/forever/npc/9549/) | Bowyer | Sun Rock Retreat | 45.4, 59.1 | Horde | Rough Arrow, Sharp Arrow | - |
| [Grawnal](https://outof.games/realms/forever/npc/4082/) | General Goods | Sun Rock Retreat | 45.9, 58.7 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Stranglethorn Vale

Map id 1434.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Haren Kanmae](https://outof.games/realms/forever/npc/2839/) | Superior Bowyer | Booty Bay | 28.3, 74.6 | Both (neutral) | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Mazk Snipeshot](https://outof.games/realms/forever/npc/2685/) | Engineering Supplies | Booty Bay | 28.5, 75.1 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot |
| [Uthok](https://outof.games/realms/forever/npc/1149/) | General Supplies | Grom'gol Base Camp | 31.6, 28 | Horde | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |
| [Corporal Bluth](https://outof.games/realms/forever/npc/734/) | Camp Trader | Rebel Camp | 38, 3 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Tanaris

Map id 1446.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Blizrik Buckshot](https://outof.games/realms/forever/npc/8131/) | Gunsmith | Gadgetzan | 50.7, 27.5 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Jabbey](https://outof.games/realms/forever/npc/8139/) | General Goods | Steamwheedle Port | 67, 22 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Teldrassil

Map id 1438.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Keina](https://outof.games/realms/forever/npc/3589/) | Bowyer | Aldrassil | 59.3, 41.1 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Lyrai](https://outof.games/realms/forever/npc/3587/) | General Supplies | Aldrassil | 59.5, 40.9 | Alliance | Rough Arrow | Light Shot |
| [Aldia](https://outof.games/realms/forever/npc/3608/) | General Supplies | Dolanaar | 55.5, 57.2 | Alliance | Rough Arrow | Light Shot |
| [Jeena Featherbow](https://outof.games/realms/forever/npc/3610/) | Bowyer | Dolanaar | 55.9, 59.2 | Alliance | Rough Arrow, Sharp Arrow | - |

## The Barrens

Map id 1413.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Jazzik](https://outof.games/realms/forever/npc/3498/) | General Supplies | Ratchet | 61.9, 38.8 | Both (neutral) | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Barg](https://outof.games/realms/forever/npc/3481/) | General Supplies | The Crossroads | 51.7, 30 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Uthrok](https://outof.games/realms/forever/npc/3488/) | Bowyer & Gunsmith | The Crossroads | 51.1, 29.1 | Horde | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## The Hinterlands

Map id 1425.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Renn'az](https://outof.games/realms/forever/npc/17598/) | Ammunition Vendor | Revantusk Village | 76.9, 81.4 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |

## Thousand Needles

Map id 1441.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Jawn Highmesa](https://outof.games/realms/forever/npc/4876/) | General Goods | Freewind Post | 45.9, 51.5 | Horde | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Starn](https://outof.games/realms/forever/npc/9551/) | Gunsmith & Bowyer | Freewind Post | 44.9, 50.7 | Horde | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Synge](https://outof.games/realms/forever/npc/3053/) | Gun Merchant | Mirage Raceway | 80.4, 77 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |

## Tirisfal Glades

Map id 1420.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Mrs. Winters](https://outof.games/realms/forever/npc/2134/) | General Supplies | Brill | 61.2, 52.6 | Horde | Rough Arrow | Light Shot |
| [Joshua Kien](https://outof.games/realms/forever/npc/2115/) | General Supplies | Deathknell | 32.3, 65.4 | Horde | Rough Arrow | Light Shot |

## Un'Goro Crater

Map id 1449.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Nergal](https://outof.games/realms/forever/npc/12959/) | General Goods Vendor | Marshal's Refuge | 43.3, 7.7 | Both (neutral) | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Westfall

Map id 1436.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [William MacGregor](https://outof.games/realms/forever/npc/1668/) | Bowyer | Sentinel Hill | 57.7, 53.9 | Alliance | Rough Arrow, Sharp Arrow | - |
| [Quartermaster Lewis](https://outof.games/realms/forever/npc/491/) | Quartermaster | Sentinel Tower | 57, 47.2 | Alliance | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |

## Wetlands

Map id 1437.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Edwina Monzor](https://outof.games/realms/forever/npc/1462/) | Fletcher | Menethil Harbor | 11.1, 58.3 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow, Jagged Arrow | - |
| [Gruham Rumdnul](https://outof.games/realms/forever/npc/1452/) | General Supplies | Menethil Harbor | 12.1, 58 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |
| [Murndan Derth](https://outof.games/realms/forever/npc/1461/) | Gunsmith | Menethil Harbor | 11.3, 59.6 | Alliance | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Naela Trance](https://outof.games/realms/forever/npc/1459/) | Bowyer | Menethil Harbor | 11.3, 58.4 | Alliance | Rough Arrow, Sharp Arrow, Razor Arrow | - |
| [Neal Allen](https://outof.games/realms/forever/npc/1448/) | Engineering & General Goods Supplier | Menethil Harbor | 10.8, 56.8 | Alliance | Sharp Arrow, Razor Arrow | Heavy Shot, Solid Shot |

## Winterspring

Map id 1452.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Wixxrak](https://outof.games/realms/forever/npc/11184/) | Weaponsmith & Gunsmith | Everlook | 61.7, 38 | Both (neutral) | - | Light Shot, Heavy Shot, Solid Shot, Accurate Slugs |
| [Natheril Raincaller](https://outof.games/realms/forever/npc/2084/) | General Goods | Starfall Village | 51.5, 30.8 | Alliance | Sharp Arrow, Razor Arrow, Jagged Arrow | Heavy Shot, Solid Shot, Accurate Slugs |

## Zephras Isle

New in WoW Forever. AmmoFinder finds it in game by the zone's name.

| Vendor | Title | Area | Coords | Faction | Arrows | Bullets |
| --- | --- | --- | --- | --- | --- | --- |
| [Antelariaa Cloudgaze](https://outof.games/realms/forever/npc/252390/) | General Goods | - | 63, 77.8 | Both (neutral) | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |
| [Tephri Thriceforged](https://outof.games/realms/forever/npc/257421/) | Tailor | - | 44.8, 44.2 | Both (neutral) | Rough Arrow, Sharp Arrow | - |
| [Uualia Suncrest](https://outof.games/realms/forever/npc/251537/) | General Goods | - | 42.8, 24.5 | Both (neutral) | Rough Arrow | Light Shot |
| [Veena Vericloud](https://outof.games/realms/forever/npc/254358/) | General Goods | - | 44.7, 45.5 | Both (neutral) | Rough Arrow, Sharp Arrow | Light Shot, Heavy Shot |


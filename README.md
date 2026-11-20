<div align="center">

<img src=".github/icon.jpg" alt="AmmoFinder icon" width="64">

# AmmoFinder

**Walk into town, find the ammo vendor.**

[![CurseForge downloads](https://img.shields.io/curseforge/dt/1811015?logo=curseforge&label=CurseForge&color=F16436)](https://www.curseforge.com/projects/1811015)
[![Latest release](https://img.shields.io/github/v/release/xibate/Ammofinder?label=release)](https://github.com/xibate/Ammofinder/releases/latest)

</div>

---

Running out of arrows or bullets in the middle of nowhere is a hunter rite of passage. AmmoFinder makes sure it happens less: when you walk into a town or city that has an ammo vendor, a banner in the style of Regions of Azeroth's zone titles tells you who sells ammo, where they stand, and how much you have left. One click on **Point me there** and an arrow on screen leads you there, with a pin and a dotted line on your map and minimap.

## Features

- **A banner when you arrive.** The vendor's name and area, your ammo count, and a **Point me there** button (or type `/ammo go`).
- **Shows you the way, like a GPS.** An arrow on screen points at the vendor with the distance and turns green when you face them. A pin on the world map and minimap (on the minimap's edge when they are further away) and a moving dotted line from you to them. It works in combat and clears itself when you arrive. Or use the game's own map pin instead.
- **Only the ammo you use.** Bows and crossbows get arrow vendors, guns get bullet vendors. Nothing shows without a ranged weapon, unless you want it to.
- **Only the ammo you want.** Any ammo for your weapon, only the best ammo for your level (Rough, Sharp, Razor, Jagged Arrows; Light, Heavy, Solid Shot, Accurate Slugs), or exactly the kinds you tick.
- **Mark the vendor.** **Point me there** also targets the vendor and puts a raid marker (star by default) on them, so they stand out in a busy city.
- **Put it where you like.** Drag the banner anywhere on screen.
- **Low ammo warning.** The banner turns red and says *Low on Ammo!* or *Out of Ammo!* below a count you choose. Or only hear about vendors when you are running low.
- **No spam.** The same town is not announced again for a while (10 minutes by default, your choice).
- **111 vendors built in.** Every Classic capital and town vendor that sells arrows or bullets, with what they sell, from warcraft.wiki.gg and Wowhead Classic. The full list, with zone, coordinates, faction and ammo, is in [VENDORS.md](VENDORS.md).
- **Only vendors you can buy from.** The other faction's vendors are never announced. Neutral towns like Booty Bay and Gadgetzan count for both.
- **Learns as you play.** Open any vendor that sells arrows or bullets and AmmoFinder remembers them, their stock and where they are. Opening a built-in vendor corrects where they stand and what they sell.
- **The right vendor.** Bowyers, gunsmiths and general goods vendors come first; a weapon merchant who also sells some ammo only when nobody else there does. The banner shows the vendor's title, and a red X closes it.

## Settings

Type `/ammo`, or open *Options > AddOns > AmmoFinder*.

| Setting | Default | What it does |
| --- | --- | --- |
| Enabled, Banner on screen, Message in chat, Play a sound | on, on, on, off | What AmmoFinder shows when you arrive |
| Also without a bow, crossbow or gun | off | Announce vendors even with no ranged weapon equipped |
| Show the banner for | 6 sec | How long the banner stays up (2 seconds more when you are low on ammo) |
| Same place again after | 10 min | How long before the same town or city is announced again. 0 announces it every time |
| Low ammo warning below | 200 | Below this count the banner turns red. 0 turns the warning off |
| Only announce when below this | off | Stay quiet while you have enough ammo, and only announce vendors once you are below the low ammo count |
| Move banner / Reset position | below the zone text | Unlocks the banner so you can drag it anywhere. Right-click it or click *Lock banner* when it's in place |
| Mark the vendor | star | Raid marker **Point me there** puts on the vendor (it targets them to do so): *Off*, or star to skull |
| Show the way with | AmmoFinder's arrow and map pins | *AmmoFinder's arrow and map pins*, or *The game's map pin* |
| Arrow on screen, Dotted line on the map and minimap | on, on | The parts of AmmoFinder's own waypoint. Drag the arrow to move it, right-click it to stop. *Reset arrow* puts it back |
| Which ammo | Any ammo for my weapon | *Any ammo for my weapon*, *Only the best ammo for my level*, or *Only the ammo I tick below* |

**Show a test banner** (or `/ammo test`) shows an example banner, to try out the length and position.

## Commands

| Command | |
| --- | --- |
| `/ammo` | Open the settings |
| `/ammo go` | Show the way to the last announced vendor |
| `/ammo clear` | Stop showing the way |
| `/ammo arrow` | Put the arrow back in its default place |
| `/ammo check` | Look for a vendor here now, ignoring the timeout |
| `/ammo test` | Show a test banner |
| `/ammo where` | Print where you stand (map coordinates), to report a vendor in the wrong place |
| `/ammo move` | Unlock the banner to drag it, or lock it again |
| `/ammo reset` | Put the banner back in its default place |
| `/ammo on` / `off` | Turn AmmoFinder on or off |
| `/ammo banner` / `chat` / `sound` / `always` | Toggle those settings |
| `/ammo list` | List the vendors you have learned |
| `/ammo debug` | Show what the marking depends on, for bug reports |

## Supported game versions

| Game version | Patch | TOC file |
| --- | --- | --- |
| WoW Forever | 1.60.1 | `AmmoFinder_Camelot.toc` (and `AmmoFinder.toc`) |
| Classic Era | 1.15.9 | `AmmoFinder_Vanilla.toc` |

The game loads the right `.toc` file for the client you are playing on.

## Installation

**With the CurseForge app (recommended):** search for **AmmoFinder** and click *Install*. Updates arrive automatically.

**Manually:**

1. Download the latest `AmmoFinder-vX.Y.Z.zip` from [CurseForge](https://www.curseforge.com/projects/1811015) or [GitHub Releases](https://github.com/xibate/Ammofinder/releases/latest).
2. Extract it into your AddOns folder, for example `World of Warcraft\_forever_\Interface\AddOns\`.
3. You should end up with `Interface\AddOns\AmmoFinder\AmmoFinder.toc`.
4. Restart the game or type `/reload`.

## Known limitations

- Forever reshaped the Stormwind, Redridge, Eastern Plaguelands and Mulgore maps, so waypoints there can be off. Open a built-in vendor's window once and AmmoFinder uses where you stood from then on.
- Vendor stock comes from Wowhead Classic. Vendors you learned before 0.4.0 have no stock saved, so they are announced whatever ammo you picked, until you open their window again.
- A learned vendor's position is where you stood when you opened their window.

## Development

- `AmmoFinder/` is the addon folder. `Data.lua` has the vendors and ammo, `AmmoFinder.lua` the banner and logic, `Waypoint.lua` the arrow, pins and map line, `Options.lua` the settings and `Theme.lua` the look, shared with Crescendo and Easy Delete.
- The icon is the game's own `Interface\Icons\INV_Ammo_Arrow_02`, The arrow, pin and line dot in `AmmoFinder/Media` are drawn by `tests/media.js` (`npm run media` in `tests`). `.github/icon.jpg` is the same icon from Wowhead, for this README.
- `cd tests && npm install && npm test` runs the addon against a mock of the WoW API. It does not replace trying it in game.
- `VENDORS.md` is generated from `Data.lua`: run `npm run vendors` in `tests` after changing the data.
- Releases: run *Publish Addon to CurseForge* from the Actions tab, or push a tag like `v0.4.0` matching `## Version` in `AmmoFinder/AmmoFinder.toc`. It needs the `CF_API_KEY` secret (a CurseForge API token). The CurseForge project id is 1811015, in `## X-Curse-Project-ID` in every `.toc` file.

## Changelog

### 0.6.0
- Shows you the way like a GPS: **Point me there** now puts an arrow on screen that points at the vendor with the distance (green when you face them), a pin on the world map and minimap, and a moving dotted line to them. It works in combat, clears itself when you arrive, and stays over a /reload. The game's map pin is still there as a setting. `/ammo clear` stops it.
- A red X on the banner closes it straight away, without waiting for it to fade.
- Bowyers, gunsmiths and general goods vendors come first. Weapon merchants who also sell some ammo (the ones you go to for repairs) are only named when nobody else there sells your ammo.
- The banner shows the vendor's title, like *Frederick Stover <Bow & Arrow Merchant>*. VENDORS.md lists the titles too.
- Opening a built-in vendor's window now also remembers what they really sell. One who sells no ammo in your game is not announced again.

### 0.5.2
- Fixed: Point me there didn't target or mark. Since the 10.0 engine a secure button only acts on the half of the click matching the "cast on key down" setting, and it was registered for mouse-up only.
- After the click, chat says whether the vendor was targeted and marked, or that they are too far away.
- `/ammo debug` shows whether this client has /tm, the key down setting, and the macro the button runs.
- Opening a built-in vendor's window now corrects their position when the shipped one is wrong, and `/ammo where` prints where you stand.
- Learned vendors remember their faction, so the other faction's vendors are skipped for them too, like the built-in ones.
- [VENDORS.md](VENDORS.md) lists every built-in vendor: zone, area, coordinates, faction, and the arrows and bullets they sell.
- Fixed: Thurman Mullby (Stormwind) now uses his position from the current Wowhead map (64.6, 71.4); the Classic one was wrong in Forever.

### 0.5.1
- Fixed: marking the vendor called SetRaidTarget from addon code, which WoW Forever blocks (ADDON_ACTION_FORBIDDEN, and a secret-value error). Marking now happens when you click **Point me there**, through a secure button.

### 0.5.0
- Only announce when low: a setting under the low ammo count that keeps AmmoFinder quiet until you have less than that.
- Move the banner: *Move banner* in the settings (or `/ammo move`) lets you drag it anywhere. *Reset position* or `/ammo reset` puts it back.
- Mark the vendor: **Point me there** also targets the vendor and puts a raid marker on them (star by default, or pick one, or off). Out of combat it is a secure button, because WoW only lets a real click target or mark; in combat it only sets the waypoint.

### 0.4.0
- Settings window (`/ammo`) and a page in *Options > AddOns*, in the style of Crescendo and Easy Delete.
- New settings: how long the banner shows, how long before the same place is announced again, banner position, low ammo count.
- Pick your ammo: any ammo, only the best ammo for your level, or the kinds you tick. Every built-in vendor now knows which of the eight vendor ammo items they sell (from Wowhead Classic), and learned vendors remember their stock.
- The banner says which of your ammo the vendor sells.
- More room around the **Point me there** button: the banner now grows to fit its text, with a clear gap above and below the button.
- The banner sits lower by default so it no longer covers the zone name.
- Removed Mazk Snipeshot (Booty Bay): Wowhead does not list him selling any ammo.
- The game's arrow icon (`INV_Ammo_Arrow_02`) in the AddOns list and settings, and the repository set up like the other addons: `.pkgmeta`, release workflow, Classic Era `.toc`.

### 0.3.0
- New banner: icon, gold title, divider, vendor and area line, ammo count line, and a **Point me there** button.
- Low ammo warning, learned vendors no longer duplicated, swapping between bow and gun re-checks.

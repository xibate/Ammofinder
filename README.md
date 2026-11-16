<div align="center">

<img src=".github/icon.jpg" alt="AmmoFinder icon" width="64">

# AmmoFinder

**Walk into town, find the ammo vendor.**

[![Latest release](https://img.shields.io/github/v/release/xibate/Ammofinder?label=release)](https://github.com/xibate/Ammofinder/releases/latest)

</div>

---

Running out of arrows or bullets in the middle of nowhere is a hunter rite of passage. AmmoFinder makes sure it happens less: when you walk into a town or city that has an ammo vendor, a banner in the style of Regions of Azeroth's zone titles tells you who sells ammo, where they stand, and how much you have left. One click on **Point me there** puts a waypoint on your map.

## Features

- **A banner when you arrive.** The vendor's name and area, your ammo count, and a **Point me there** button that sets a map waypoint (or type `/ammo go`).
- **Only the ammo you use.** Bows and crossbows get arrow vendors, guns get bullet vendors. Nothing shows without a ranged weapon, unless you want it to.
- **Only the ammo you want.** Any ammo for your weapon, only the best ammo for your level (Rough, Sharp, Razor, Jagged Arrows; Light, Heavy, Solid Shot, Accurate Slugs), or exactly the kinds you tick.
- **Mark the vendor.** **Point me there** also targets the vendor and puts a raid marker (star by default) on them, so they stand out in a busy city.
- **Put it where you like.** Drag the banner anywhere on screen.
- **Low ammo warning.** The banner turns red and says *Low on Ammo!* or *Out of Ammo!* below a count you choose. Or only hear about vendors when you are running low.
- **No spam.** The same town is not announced again for a while (10 minutes by default, your choice).
- **111 vendors built in.** Every Classic capital and town vendor that sells arrows or bullets, with what they sell, from warcraft.wiki.gg and Wowhead Classic.
- **Learns as you play.** Open any vendor that sells arrows or bullets and AmmoFinder remembers them, their stock and where they are.

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
| Which ammo | Any ammo for my weapon | *Any ammo for my weapon*, *Only the best ammo for my level*, or *Only the ammo I tick below* |

**Show a test banner** (or `/ammo test`) shows an example banner, to try out the length and position.

## Commands

| Command | |
| --- | --- |
| `/ammo` | Open the settings |
| `/ammo go` | Set a waypoint to the last announced vendor |
| `/ammo check` | Look for a vendor here now, ignoring the timeout |
| `/ammo test` | Show a test banner |
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

1. Download the latest `AmmoFinder-vX.Y.Z.zip` from [GitHub Releases](https://github.com/xibate/Ammofinder/releases/latest).
2. Extract it into your AddOns folder, for example `World of Warcraft\_forever_\Interface\AddOns\`.
3. You should end up with `Interface\AddOns\AmmoFinder\AmmoFinder.toc`.
4. Restart the game or type `/reload`.

## Known limitations

- Forever reshaped the Stormwind, Redridge, Eastern Plaguelands and Mulgore maps, so waypoints there can be a little off.
- Vendor stock comes from Wowhead Classic. Vendors you learned before 0.4.0 have no stock saved, so they are announced whatever ammo you picked, until you open their window again.
- A learned vendor's position is where you stood when you opened their window.

## Development

- `AmmoFinder/` is the addon folder. `Data.lua` has the vendors and ammo, `AmmoFinder.lua` the banner and logic, `Options.lua` the settings and `Theme.lua` the look, shared with Crescendo and Easy Delete.
- The icon is the game's own `Interface\Icons\INV_Ammo_Arrow_02`, so the addon ships no textures. `.github/icon.jpg` is the same icon from Wowhead, for this README.
- `cd tests && npm install && npm test` runs the addon against a mock of the WoW API. It does not replace trying it in game.
- Releases: run *Publish Addon to CurseForge* from the Actions tab, or push a tag like `v0.4.0` matching `## Version` in `AmmoFinder/AmmoFinder.toc`. It needs a `CF_API_KEY` secret and a `## X-Curse-Project-ID` line in the `.toc` files once the CurseForge project exists.

## Changelog

### 0.5.2
- Fixed: Point me there didn't target or mark. Since the 10.0 engine a secure button only acts on the half of the click matching the "cast on key down" setting, and it was registered for mouse-up only.
- After the click, chat says whether the vendor was targeted and marked, or that they are too far away.
- `/ammo debug` shows whether this client has /tm, the key down setting, and the macro the button runs.

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

# CurseForge project text

Copy the parts below into the CurseForge project settings. This file is not packaged (see `.pkgmeta`).

## Summary

Never run dry: a banner tells you which vendor in town sells your arrows or bullets, and one click sets a waypoint to them.

Shorter alternative:

Walk into town, find the ammo vendor. A banner and a one-click waypoint for hunters.

## Description

Paste everything below the line into the description editor with the format set to **Markdown**.

---

# AmmoFinder

**Walk into town, find the ammo vendor.**

Running out of arrows or bullets in the middle of nowhere is a hunter rite of passage. AmmoFinder makes sure it happens less.

When you walk into a town or city that has an ammo vendor, a banner in the style of the zone titles tells you **who sells ammo, where they stand, and how much you have left**. One click on **Point me there** puts a waypoint on your map, targets the vendor and marks them with a raid icon so they stand out in a busy city.

## Features

- **A banner when you arrive.** The vendor's name and area, your ammo count, and a **Point me there** button that sets a map waypoint (or type `/ammo go`).
- **Only the ammo you use.** Bows and crossbows get arrow vendors, guns get bullet vendors. Nothing shows without a ranged weapon, unless you want it to.
- **Only the ammo you want.** Any ammo for your weapon, only the best ammo for your level, or exactly the kinds you tick.
- **Mark the vendor.** **Point me there** also targets the vendor and puts a raid marker on them (star by default, or pick your own).
- **Low ammo warning.** The banner turns red and says *Low on Ammo!* or *Out of Ammo!* below a count you choose. Or only hear about vendors when you are running low.
- **No spam.** The same town is not announced again for a while (10 minutes by default, your choice).
- **Put it where you like.** Drag the banner anywhere on screen.
- **111 vendors built in.** Every Classic capital and town vendor that sells arrows or bullets, with what they sell. See the [full vendor list](https://github.com/xibate/Ammofinder/blob/main/VENDORS.md).
- **Only vendors you can buy from.** The other faction's vendors are never announced. Neutral towns like Booty Bay and Gadgetzan count for both.
- **Learns as you play.** Open any vendor that sells arrows or bullets and AmmoFinder remembers them, their stock and where they are.

## Settings

Type `/ammo`, or open *Options > AddOns > AmmoFinder*. You can choose:

- Banner, chat message and sound on or off
- How long the banner stays up, and how long before the same town is announced again
- The low ammo count, and whether to only announce vendors below it
- Which raid marker to put on the vendor, or none
- Which ammo you care about
- Where the banner sits on screen

**Show a test banner** (or `/ammo test`) lets you try out the look and position.

## Commands

- `/ammo` - open the settings
- `/ammo go` - set a waypoint to the last announced vendor
- `/ammo check` - look for a vendor here now
- `/ammo test` - show a test banner
- `/ammo move` / `/ammo reset` - move the banner, or put it back
- `/ammo on` / `/ammo off` - turn AmmoFinder on or off
- `/ammo list` - list the vendors you have learned
- `/ammo where` - print your map coordinates, to report a vendor in the wrong place

## Supported versions

- **WoW Forever** (1.60.1)
- **Classic Era** (1.15.9)

## Known limitations

- Forever reshaped the Stormwind, Redridge, Eastern Plaguelands and Mulgore maps, so waypoints there can be off. Open a built-in vendor's window once and AmmoFinder uses where you stood from then on.
- Targeting and marking only work out of combat, because WoW only allows that from a real click. In combat **Point me there** just sets the waypoint.

## Feedback

Found a vendor in the wrong place, or one that is missing? Stand next to them, type `/ammo where`, and report it on [GitHub](https://github.com/xibate/Ammofinder/issues) or in the comments.

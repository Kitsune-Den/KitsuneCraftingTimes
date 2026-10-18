# KitsuneCraftingTimes

🦊 **Part of the [Kitsune Systems Collection](https://github.com/Kitsune-Den)** ~
[KitsuneTrapXP](https://github.com/Kitsune-Den/KitsuneTrapXP) ·
[KitsuneFuelSaver](https://github.com/Kitsune-Den/KitsuneFuelSaver) ·
[KitsunePvPExtended](https://github.com/Kitsune-Den/KitsunePvPExtended) ·
[KitsuneZombieReach](https://github.com/Kitsune-Den/KitsuneZombieReach) ·
[KitsuneKitchen7D](https://github.com/Kitsune-Den/KitsuneKitchen7D) ·
[KitsuneFoxacary](https://github.com/Kitsune-Den/KitsuneFoxacary)

**Crafting takes less time. Pick how much. For 7 Days to Die V3.0 – V3.3.**

You queue up 500 rounds of 9mm, look at the timer, and it says twenty minutes. Then you queue 7.62 behind it and the workbench is busy until next Tuesday. Ammo, arrows, cement, pipe bombs, it all adds up, and the time you spend waiting on a progress bar is time you're not playing.

This mod cuts crafting time across the board. Every recipe, in your backpack and at every workstation. Four speeds, install the one you want.

## Pick a speed

| Tier | Folder | Craft time | 9mm round (vanilla 2.4s) | 500 rounds |
|---|---|---|---|---|
| Little | `KitsuneCraftingTimes_Little` | 25% less (0.75x) | 1.8s | 15 min |
| Medium | `KitsuneCraftingTimes_Medium` | 50% less (0.5x) | 1.2s | 10 min |
| Fast | `KitsuneCraftingTimes_Fast` | 75% less (0.25x) | 0.6s | 5 min |
| Faster | `KitsuneCraftingTimes_Faster` | 90% less (0.1x) | 0.24s | 2 min |

(Vanilla: 500 rounds of 9mm is 20 minutes before perks.)

## Install

1. Grab the zip for the tier you want from the [Releases](https://github.com/Kitsune-Den/KitsuneCraftingTimes/releases) page.
2. Drop that **one** `KitsuneCraftingTimes_<Tier>` folder into `Mods/`.
3. Restart the game or server.

**Only install one tier.** They all share the same internal mod name, so if two end up in `Mods/` the game loads only one of them and skips the rest (check the log). To switch tiers, swap the folder and restart.

- **XML-only.** No DLL, so **EAC can stay on.**
- **Server-side.** On a dedicated or hosted server, install it on the server only. The game sends XML config to clients when they join, so players don't need to install anything.
- **Existing saves are fine.** Add or remove it whenever you want. Nothing is written to your save.

## What it actually does

It gives the player a `CraftingTime` passive effect. That's the same stat vanilla perks use (Advanced Engineering, Pack Mule, Chemistry Station perks, Master Chef). The game reads it whenever you queue a recipe, so the shorter time shows up right in the crafting UI.

One XPath append to `entityclasses.xml` on `playerMale` (`playerFemale` inherits it):

```xml
<passive_effect name="CraftingTime" operation="perc_add" value="-0.5"/>
```

### Stacking with perks

Vanilla adds all `CraftingTime` bonuses together, and this one stacks with them the same way. Example: Medium (-50%) plus Advanced Engineering's workbench bonus (-40%) comes out to 90% less time at the workbench.

The game won't let craft time go below zero, so on **Fast** or **Faster** with perks, some recipes become **instant**. That's intended. If it's too much for you, drop a tier.

### What it doesn't touch

- **Forge smelting** uses a separate stat (`CraftingSmeltTime`). Ore still smelts at vanilla speed.
- **Scrapping** uses `ScrappingTime`. Unchanged.
- **Cooking at Master Chef 0.** Vanilla makes early cooking *much* slower (up to +400% at the campfire) until you put points into Master Chef. This mod still takes its cut off that total, so cooking is faster than vanilla, just not by the full tier amount.

## Vanilla sandbox option

V3.x has a **Crafting Time** setting in the sandbox options for new games. If you're starting a fresh world and it gives you what you want, use that. This mod is for existing saves, servers where you'd rather drop in a folder than change world settings, or when you want one of these specific tiers. Both multiply together if you use them at the same time.

## Building a release

```
build-release.bat
```

Zips each tier folder into `dist/KitsuneCraftingTimes_<Tier>-v<version>.zip`, ready to attach to a GitHub release.

## Compatibility

Checked against V3.2 and V3.3 (experimental) game data: the XPath target (`entity_classes/entity_class[@name='playerMale']`) and the `CraftingTime` passive are present in both, and the crafting-time math (`XUiM_Recipes.GetRecipeCraftTime`) was confirmed against the decompiled V3.x assembly.

Overhauls that replace the player entity class (instead of extending `playerMale`) will make the XPath a no-op. Nothing breaks, it just won't apply.

## License

[CC BY-NC-SA 4.0](LICENSE), with an extra permission for servers that make money: see [NOTICE.md](NOTICE.md). In short: play it, change it and share it, with credit, not for sale, and with changed versions under the same license.

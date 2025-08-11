# HDCoreLib

This is a collection of shared utility methods, classes, and libraries used by the HDest Community.

## Features

- A centralized suite of functionality driven by a command-driven system, using a simple `command => params` syntax defined in a text lump named `HDCINFO` at the root of a PK3.
  - more information regarding how to write your own commands can be found below.
- A collection of dummy spawners that can be triggered/spawned off of, or replaced entirely, in case addons wish to add their own content in various sectors without needing to implement the logic to do so; simply add spawn tables for these actors as you would any others.
  - Currently HDCoreLib spawns dummy spawners for the following situations:
    - Secret Sectors
    - Outdoor Sectors
    - Hurtfloor Sectors
    - Deathmatch Spawn Locations
- A centralized handler for registering and assigning ammunition and it's users.
- A centralized handler for adding/removing items to/from Backpack and Ammo Box spawn pools.
- A centralized handler to track and cache each player's `FLineTrace` data every game tic, so that addons don't need to waste processing resources tracking it themselves, just grab the EventHandler and access the data for the desired player.
- A centralized handler that manages a Static Thinker used for storing and retrieving any data and addon may want over the course of a playthrough.
  - By default, the handler tracks how many maps the player(s) have completed.
  - The handler has a set of `get()` and `set()` methods to track additional information as desired. *NOTE*: setting values requires Play scope, whereas getting values can be done in both UI as well as Data scope.
- A centralized Spawn Replacement Pipeline Event Handler, driven by commands, to reduce mapload churn, improve consistency in replacement chances, and overall improve the configurability of addons and tweaks mods alike.
- A collection of various third-party ZScript libraries:
  - Gutamatics
  - LibToolTipMenu
  - ZForms
  - ZJSON

### HDCINFO Commands

- HDCoreLib ships a default suite of these commands both as to provide examples as well as a default implementation of this functionality to build off of without needing to be reimplemented.
- Params are specific to each command, but every command can define a `enabled: true/false` parameter that can be used to ignore the command.
- Params can be set to all sorts of values, even though they are defined as strings in the file.
  - Static values including `"Strings"`, `'Names'`, `Integers`, `Doubles`, and `Booleans`.
  - CVARs when prefixed with `#` (`"#my_cool_cvar"`)
  - Localized Strings when prefixed with `$` (`"$TAG_MY_COOL_PISTOL"`)
  - Functions which can use their own set of parameters, when prefixed with `@` (`"@classExists"`)
    - All parameters for a given function will be prefixed with the name of the parameter set to the function, followed by a period.
      - For example, setting the "enabled" parameter to check whether a class of a given name exists would require setting two total parameters: the enabled param to be the function itself, and the name of the class to what needs to be checked (`"enabled": "@classExists", "enabled.name": "MyCoolClass"`).  This will cause the `enabled` parameter to invoke the method to check if the class with the name given in the `enabled.name` param exists and return that value.

### SPECIFC COMMAND DOCUMENTATION: WIP

## Credits

- [Gutamatics Library](./zscript/libs/HDGutamatics/LICENSE.md): Gutawer
- [ZForms Library](./zscript/libs/HDZForms/LICENSE.md): Gutawer, Phantombeta
- [ZJSON Library](https://github.com/RicardoLuis0/ZJSON): RicardoLuis0
- CameraContext: ArgV-Minus-One
- [Damped Spring](https://gist.github.com/caligari87/39d1cec3aad776860b4148cc3c659f70): Caligari
- [LibToolTipMenu](./zscript/libs/HDlibtooltipmenu/COPYING.md): ToxicFrog
- Spawn Handler: FDA, Swampyrad, TedTheDragon
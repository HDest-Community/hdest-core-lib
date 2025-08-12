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
- A centralized logging framework, inspired by the likes of [Log4J](https://en.wikipedia.org/wiki/Log4j), utilizing defined logging levels to allow addon devs to focus more on the actual log messages and less about checking whether they should or worrying about formatting.
- A centralized handler for registering and assigning ammunition and it's users.
- A centralized handler for adding/removing items to/from Backpack and Ammo Box spawn pools.
- A centralized handler to track and cache each player's `FLineTrace` data every game tic, so that addons don't need to waste processing resources tracking it themselves, just grab the EventHandler and access the data for the desired player.
- A centralized handler that manages a Static Thinker used for storing and retrieving any data and addon may want over the course of a playthrough.
  - By default, the handler tracks how many maps the player(s) have completed.
  - The handler has a set of `get()` and `set()` methods to track additional information as desired. *NOTE*: setting values requires Play scope, whereas getting values can be done in both UI as well as Data scope.
- A centralized Spawn Replacement Pipeline Event Handler, driven by commands, to reduce mapload churn, improve consistency in replacement chances, and overall improve the configurability of addons and tweaks mods alike.
- A generic default safety net handler for checking replacees based on various actor flags and their relevant maps, so that addon devs don't need to worry about reimplementing such logic.
  - When on one of the following maps, when a thing dies with the given flag, it's considered to have replaced the resulting actor:
    - `E1M8`,  `E1M8BOSS`,   `BaronOfHell`
    - `E2M8`,  `E2M8BOSS`,   `Cyberdemon`
    - `E3M8`,  `E3M8BOSS`,   `SpiderMastermind`
    - `E4M8`,  `E4M8BOSS`,   `SpiderMastermind`
    - `MAP07`, `MAP07BOSS1`, `Fatso`
    - `MAP07`, `MAP07BOSS2`, `Arachnotron`
- A collection of various third-party ZScript libraries:
  - Gutamatics
  - LibToolTipMenu
  - ZForms
  - ZJSON

### Spawn Tables

This is the bulk of the commands provided by default, and will be the more complicated set of commands this library provides.  The core of this system lies two fundamental pieces, tables and entries.  Whenever GZDoom checks for Actor replacement via `checkReplacement`, the spawn handler fetches all tables marked for replacements matching the configured `spawnName`.  Once it has the collection of tables, it rolls against these tables and selects an entry within them based on their relative weights/biases within the table.

A table consisting of just single entries is enough for the majority of use cases.  However, there may be times when addons want to group multiple entries together under a single entry in another table.  This is where Nesting tables within other tables comes in handy.  HDCoreLib will handle recursively digging into these nested tables, until a single entry is found to replace the orginal actor with.

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

### SPECIFIC COMMAND DOCUMENTATION
NOTE: The [provided `HDCINFO` lump](./HDCINFO) provides both documentation as well as the default implementation of various commands as well, if that's more your speed.

#### Spawn Handler Blacklist
These commands register various things and/or maps to be skipped during Spawn Replacement.  Useful for keeping the Firing Range pristine, or ignoring any VFX actors/thinkers.

`addSpawnHandlerMapBlacklist`
- Adds the given mapname to check against to the blacklist
- Params:
  - `name`: [Name] The name of map to blacklist (e.g. `MAP01`, `E1M8`, etc.)
- `addSpawnHandlerMapBlacklist => { "name": "E1M1" }`

`addSpawnHandlerThingBlacklist`
- Adds the given Thing to check against to the blacklist
- Params:
  - `name`: [Name] The ClassName of the thing to blacklist
- `addSpawnHandlerThingBlacklist => { "name": "HDSmoke" }`

#### Ammo Usage Blacklist
These commands register various things to be skipped during Ammo Usage Assignment.

`addAmmoThingBlacklist`
- Adds the given thing to the check against to the blacklist
- Params:
  - `name`: [Name] The ClassName of the thing to blacklist
- `addAmmoThingBlacklist => { "name": "HDSmoke" }`

#### Ammo Associations
These commands manipulate registries of both classes to be defined as ammunition as well as users of those ammunition.

`newAmmo`
- Adds a new ammo association entry
- params:
  - `ammoName`: [Name] ClassName of the ammo to check against when adding things that use it
- `newAmmo => { "ammoName": "FourMilAmmo" }`

`addAmmoUser`
- Add a new ammo association to the given ammo type
- params:
  - `ammoName`: [Name] Name of the ammo to associate
  - `name`: [Name] ClassName of the thing to associate with the ammo
- `addAmmoUser => { "ammoName": "HDPistolAmmo", "name": "MyCoolPistol" }`

`removeAmmo`
- Remove an existing ammo association entry
- params:
  - `ammoName`: [Name] ClassName of the ammo to remove
- `removeAmmo => { "ammoName": "SevenMilAmmo" }`

`removeAllAmmo`
- Remove all existing ammo associations
- `removeAllAmmo => {}`

#### Ammo Box Spawn Pool
These commands modify contents of the pool of ammo to spawn when unlocking/opening an Ammo Box.

`addAmmoBoxFilter`
- Add a new ammo to the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to add
  - `allowed`: [Boolean] Used to determine if ammo should be removed from blacklist if true, otherwise added
- `addAmmoBoxFilter => { "ammoName": "FourMilAmmo", "allowed": "true" }`

`addAmmoBoxWhitelist`
- Add a new ammo to the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to add
- `addAmmoBoxWhitelist => { "ammoName": "FourMilAmmo" }`

`removeAmmoBoxWhitelist`
- Remove an existing ammo from the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to remove
- `removeAmmoBoxWhitelist => { "ammoName": "SevenMilAmmo" }`

`clearAmmoBoxWhitelist`
- Remove all existing ammo from whitelist
- `clearAmmoBoxWhitelist => {}`

`addAmmoBoxBlacklist`
- Add a new ammo to the blacklist
- params:
  - `ammoName`: [Name] Name of the ammo to add
- `addAmmoBoxBlacklist => { "ammoName": "FourMilAmmo" }`

`removeAmmoBoxBlacklist`
- Remove an existing ammo from the blacklist
- params:
  - `ammoName`: [Name] Name of the ammo to remove
- `removeAmmoBoxBlacklist => { "ammoName": "SevenMilAmmo" }`

`clearAmmoBoxBlacklist`
- Remove all existing ammo from blacklist
- `clearAmmoBoxBlacklist => {}`

#### Backpack Spawn Pool
These commands modify contents of the pool of items to fill backpacks found in the wild with.  
**NOTE:** The existing restrictions on items that can be found in backpacks will still apply.

`addBPSpawnPoolFilter`
- Add a new ammo to the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to add
  - `allowed`: [Boolean] Used to determine if ammo should be removed from blacklist if true, otherwise added
- `addBPSpawnPoolFilter => { "ammoName": "HDInvulnerabilitySphere", "allowed": "true" }`

`addBPSpawnPoolWhitelist`
- Add a new ammo to the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to add
- `addBPSpawnPoolWhitelist => { "ammoName": "HDBlursphere" }`

`removeBPSpawnPoolWhitelist`
- Remove an existing ammo from the whitelist
- params:
  - `ammoName`: [Name] Name of the ammo to remove
- `removeBPSpawnPoolWhitelist => { "ammoName": "HDMegaSphere" }`

`clearBPSpawnPoolWhitelist`
- Remove all existing ammo from whitelist
- `clearBPSpawnPoolWhitelist => {}`

`addBPSpawnPoolBlacklist`
- Add a new ammo to the blacklist
- params:
  - `ammoName`: [Name] Name of the ammo to add
- `addBPSpawnPoolBlacklist => { "ammoName": "HDBlursphere" }`

`removeBPSpawnPoolBlacklist`
- Remove an existing ammo from the blacklist
- params:
  - `ammoName`: [Name] Name of the ammo to remove
- `removeBPSpawnPoolBlacklist => { "ammoName": "HDMegaSphere" }`

`clearBPSpawnPoolBlacklist`
- Remove all existing ammo from blacklist
- `clearBPSpawnPoolBlacklist => {}`

#### Spawn Tables
These commands modify the existence and contents of various weighted random spawn tables.  These can be marked as persistent (considered beyond mapload), replacement (instead of spawning in addition to, leveraging `checkReplacement` instead of `worldThingSpawned` Events).

`newSpawnTable`
- Add a new empty Spawn Table
- params:
  - `spawnName`: [Name] ClassName of thing to be replaced or add spawns to
  - `tableName`: [Name] _Optional_ Custom name of SpawnTable _(Defaults to "spawnName")_
  - `replaces`: [Boolean] _Optional_ If true, entry will replace the "spawnName", instead of spawn alongside it _(Defaults to true)_
- `newSpawnTable => { "spawnName": "DoomImp", "tableName": "impTest" }`

`addSpawnTableSingleEntry`
- Add a single entry to an existing table
- params:
  - `tableName`: [Name] Name of SpawnTable
  - `name`: [Name] ClassName of thing to replace with or spawn
  - `weight`: [Double] The bias of this entry
  - `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
  - `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
  - `chance`: [Integer] Used to define the chance out of 256 that the selected entry will spawn successfully _(Defaults to 256)_
- `addSpawnTableSingleEntry => { "tableName": "impTest", "name": "WitheredSpawner", "weight": "69" }`

`addSpawnTableNestedEntry`
- Add a nested table entry to an existing table
- `tableName`: [Name] Name of spawnTable to add new entry to
- `name`: [Name] Name of SpawnTable (spawnName is inherited)
- `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
- `chance`: [Integer] _Optional_ Used to define the chance out of 256 that the selected entry will spawn successfully _(Defaults to 256)_
- `addSpawnTableNestedEntry => { "tableName": "impTest", "name": "zombiemanTest" }`

`removeSpawnTableEntry`
- Remove an entry from an existing table
- `tableName`: [Name] Name of spawnTable to remove entry from
- `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
- `removeSpawnTableEntry => { "tableName": "impTest", "name": "DoggySpawner" }`

`clearSpawnTable`
- Remove all entries from an existing table
- `tableName`: [Name] Name of spawnTable to clear
- `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
- `clearSpawnTable => { "tableName": "impTest" }`

`appendSpawnTableEntries`
- Append all entries from sourceTable into destTable
- `sourceTableName`: [Name] Name of spawnTable to copy entries from
- `destTableName`: [Name] Name of spawnTable to copy entries into
- `persists`: [Boolean] _Optional_ Used to find spawnTables with matching property value _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTables with matching property value _(Defaults to true)_
- `appendSpawnTableEntries => { "sourceTableName": "impTest", "destTableName": "zombiemanTest" }`

`setSpawnTableEntryWeight`
- Set the bias/weight of a single entry in an existing table
- `tableName`: [Name] Name of SpawnTable
- `name`: [Name] ClassName of thing used to find the entry to modify
- `weight`: [Double] The new bias of this entry.  If set to 0 or less, the entry will recalculate its weight automatically.
  - For single entries, the weight simply stays the same
  - For nested entries, the weight is recalculated as the sum of the weights of its entries
- `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
- `setSpawnTableEntryWeight => { "tableName": "impTest", "name": "WitheredSpawner", "weight": "420" }`

`removeSpawnTable`
- Remove an existing table entirely
- `tableName`: [Name] Name of spawnTable to remove
- `persists`: [Boolean] _Optional_ Whether the entry will be used beyond initial map spawns _(Defaults to false)_
- `replaces`: [Boolean] _Optional_ Used to find spawnTable with matching property value _(Defaults to true)_
- `removeSpawnTable => { "tableName": "impTest" }`

`removeAllSpawnTables`
- Remove all existing spawn tables
- `removeAllSpawnTables => {}`


## Credits

- [Gutamatics Library](./zscript/libs/HDGutamatics/LICENSE.md): Gutawer
- [ZForms Library](./zscript/libs/HDZForms/LICENSE.md): Gutawer, Phantombeta
- [ZJSON Library](https://github.com/RicardoLuis0/ZJSON): RicardoLuis0
- CameraContext: ArgV-Minus-One
- [Damped Spring](https://gist.github.com/caligari87/39d1cec3aad776860b4148cc3c659f70): Caligari
- [LibToolTipMenu](./zscript/libs/HDlibtooltipmenu/COPYING.md): ToxicFrog
- Spawn Handler: FDA, Swampyrad, TedTheDragon
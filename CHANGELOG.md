# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v1.1.0] - 2026-08-18

### Added

-   Added `HDCoreWildBackpack` Actor for configurable backpack contents due to new HDest Backpack/StorageContainer rework
-   Added HSL/HSV to RGB color math helper functions
-   Added CVAR for Sector Spawner sampling maximum number of attempts to find a new position
-   Added `getMicroCellIcon()` Helper Method
-   Added `getMicroCellColor()` Helper Method
-   Added `HDCoreLoggingService` to begin providing a proper public API of sorts, and to aid in softening the dependency during adoption

### Changed

-   **BREAKING** Replaced `BackpackSpawnPoolHandler` with new `StorageItemListHander` for new HDest Backpack/StorageContainer rework
-   Refined `GameStatsHandler` to track re-opened maps
-   **BREAKING** Fixed `HDZJJson*` Class Names with `HDZJson*`
-   Update `VectorPrefab` rotations to use enums instead of int literals
-   Actually wired up `drawBar()` alpha parameter
-   Enhance Logging to use `debugPrintf()` instead of simply `printf()` to make use of the `developer` CVAR
-   **BREAKING** Prefer `M_PI` constant over `HDCONST_PI` as it's defined from ZDoom itself
-   Refine Poisson Sampling Logic
-   Moved LT-specific HDCINFO to `doom.freedoom` filter

## [v1.0.0] - 2026-02-24

### Added

-   Initial Release!
-   HDCINFO Custom Text Lump
-   Unified Spawn Handlers
-   Various Static Helper Functions
    -   Actor Spawning Helpers
    -   Class-based boilerplate APIs
    -   Color Math Helpers
    -   Font & Font Color Helpers
    -   Inventory Checking Helpers
    -   Players & Player Metadata Helpers
    -   Random Number Generation, including preferences for various modes of seeded random
    -   Sector Math Helpers
    -   Texture Helpers
    -   UI Drawing Helpers
        -   Vector Prefabs
        -   Scaleable DrawBar
        -   Camera Context Data Struct
-   Centralized LineTrace Handler/Provider
-   Centralized Logging System, inspired by Log4J, customizable log template, Namespace-based filtering still WIP/TBD.
-   Universal Statistics Tracking System for both per-map & per-game tracking
-   Sector-based Spawning System for additional decorations, clutter, monsters, etc.
-   Base Melee Weapon Class
-   Base Event Handler Classes
-   Bundled copy of AceCoreLib (Standalone version is considered deprecated)
-   Imported various helper libraries
    -   [Damped Spring](https://gist.github.com/caligari87/39d1cec3aad776860b4148cc3c659f70)
    -   [Gutamatics Library](./zscript/libs/HDGutamatics/LICENSE.md)
    -   [LibToolTipMenu](./zscript/libs/HDlibtooltipmenu/COPYING.md)
    -   [ZForms Library](./zscript/libs/HDZForms/LICENSE.md)
    -   [ZJSON Library](https://github.com/RicardoLuis0/ZJSON/blob/9a6be707c26ef14e276f09ff1ad6948ca44cb5e2/LICENSE)

[Unreleased]: https://github.com/HDest-Community/hdest-core-lib/compare/v1.1.0...HEAD

[v1.1.0]: https://github.com/HDest-Community/hdest-core-lib/compare/v1.0.0...v1.1.0

[v1.0.0]: https://github.com/HDest-Community/hdest-core-lib/releases/tag/v1.0.0

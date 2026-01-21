# 1.1.3+1

- Introduced unified smart scaling unit (`.scale`) for size, radius, and layout
- Added separate font scaling with independent multiplier
- Orientation-aware scaling for landscape and large screens
- Dynamic design-frame detection for tablet/desktop
- Optional aspect-ratio aware scaling logic
- Support custom scaling curves for ultra-large (4K+) displays
- Improved core scale initialization reliability
- Refactored responsive utilities for production stability
- Bumped orkitt_core to v0.0.4+1 (API stabilized, v2.0 ready)

## v1.1.0 

### Added

* Integrated **Melos** for managing a scalable Flutter monorepo.
* Enabled shared local dependencies across all Orkitt packages.
* Improved repository structure for better modularity and maintainability.

### Changed

* Refactored package organization to align with monorepo best practices.
* Standardized tooling and dependency resolution across packages.

---

## v1.0.0 — Initial Stable Release

The first stable release of **Orkitt Framework** — a modular Flutter framework built to simplify responsive design, theming, and UI composition.

### Key Features

#### Responsive Core

* Screen scaling utilities and adaptive layout helpers.
* Breakpoint-based design system for consistent responsiveness.

#### Theme Engine

* Extensible color system and typography definitions.
* Centralized branding and theming support.

#### UI Components

* Pre-styled buttons, forms, cards, and feedback widgets.
* Designed for rapid prototyping and production readiness.

#### Utility Extensions

* Helpers for data formatting, async workflows, and widget composition.

#### Navigation & State

* Routing extensions and lifecycle-aware state utilities.

### Architecture

* Clear module boundaries: **Core**, **Views**, **Utils**, **Services**, and **Models**.
* Bootstrap-inspired responsive engine for flexible layouts.
* Fully compatible with modern Flutter tooling and workflows.


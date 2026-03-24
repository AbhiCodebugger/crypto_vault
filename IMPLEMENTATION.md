# Implementation Plan - CryptoVault

## Overview
This document outlines the phased implementation of the CryptoVault application. After each phase, the "Journal" section will be updated with progress, learnings, and any deviations from the plan.

## Journal
*   **2026-03-24**: Phase 1 completed. Created Flutter project with `empty` flag. Updated `pubspec.yaml` with necessary dependencies for BLoC, Hive, and UI. Removed boilerplate `test` directory. Initialized `CHANGELOG.md` and `README.md`.
    *   *Correction*: Adjusted `hive_ce_generator` version to `^1.11.1` for compatibility.
    *   *Platform Correction*: Restricted platforms to `android` and `ios` only, removing others.
*   **2026-03-24**: Phase 2 completed. Established Clean Architecture directory structure. Implemented core classes for Failures, UseCases, and AppTheme (Material 3). Set up dependency injection using `GetIt` and initialized Hive.
*   **2026-03-24**: Phase 3 completed. Defined `Coin` and `HistoricalData` entities. Created `CryptoRepository` interface. Implemented Use Cases for getting top coins, coin details, and historical data. Added `dartz` package for functional error handling.
*   **2026-03-24**: Phase 4 completed. Implemented `CoinModel` and `HistoricalDataModel` with JSON serialization. Created `CryptoRemoteDataSource` using `dio` to connect to `freecryptoapi.io`. Implemented `CryptoRepositoryImpl`. Set up API configuration and secured it with `.gitignore`. Registered all dependencies in the injection container.
*   **2026-03-24**: Phase 5 completed. Implemented `PortfolioItem` entity and `PortfolioItemModel` with Hive annotations. Created `PortfolioLocalDataSource` and `PortfolioRepositoryImpl`. Implemented use cases for managing the portfolio. Generated Hive adapters and registered them in the injection container.
*   **2026-03-24**: Phase 6 completed. Implemented `CryptoBloc` for real-time tracking, `ChartBloc` for historical data, and `PortfolioBloc` for holdings management. Registered all Blocs as factories in the injection container.
*   **2026-03-24**: Phase 7 completed. Built the full UI including `HomeScreen` with real-time list, `DetailsScreen` with interactive `fl_chart`, and `PortfolioScreen` with asset management. Implemented Material 3 theming across all screens.

---

## Phase 1: Foundation & Project Setup
- [x] Create a Flutter package in the current directory using `create_project`.
  - [x] Target directory: `.`
  - [x] Project type: `flutter`
  - [x] Flag: `empty`
- [x] Remove any boilerplate in the new package that will be replaced, including the `test` dir.
- [x] Update `pubspec.yaml`:
  - [x] Set `description` to "A real-time cryptocurrency price tracking and portfolio management app."
  - [x] Set `version` to `0.1.0`.
  - [x] Add initial dependencies: `flutter_bloc`, `bloc`, `hive_ce`, `hive_ce_flutter`, `dio`, `get_it`, `equatable`, `fl_chart`, `google_fonts`, `intl`.
  - [x] Add dev dependencies: `build_runner`, `hive_ce_generator`, `mocktail`, `bloc_test`.
- [x] Update `README.md` with a placeholder description.
- [x] Create `CHANGELOG.md` with version `0.1.0` and "Initial project setup."
- [x] Commit this empty version of the package.
- [x] Start running the app with `launch_app` on the preferred device.
- [x] **Validation Phase**:
  - [x] Run `dart_fix`.
  - [x] Run `analyze_files` and fix issues.
  - [x] Run `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "chore: initial project setup".
  - [ ] Wait for user approval of the commit.

## Phase 2: Core Architecture & Utilities
- [x] Define the project structure: `lib/core`, `lib/features`.
- [x] Implement `core/error/failures.dart` and `core/usecases/usecase.dart`.
- [x] Set up Dependency Injection with `get_it` in `lib/injection_container.dart`.
- [x] Configure `core/theme/app_theme.dart` for Material 3 Light/Dark themes.
- [x] **Validation Phase**:
  - [x] Create/modify unit tests for core utilities.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: setup core architecture and theme".
  - [ ] Wait for user approval and `hot_reload`.

## Phase 3: Domain Layer (Coins & Historical Data)
- [x] Define `Coin` and `HistoricalData` entities in `lib/features/crypto/domain/entities/`.
- [x] Create `CryptoRepository` interface.
- [x] Implement Use Cases: `GetTopCoins`, `GetCoinDetails`, `GetHistoricalData`.
- [x] **Validation Phase**:
  - [x] Write unit tests for use cases using `mocktail`.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: implement crypto domain layer".
  - [ ] Wait for user approval.

## Phase 4: Data Layer (Remote & API)
- [x] Create `CoinModel` and `HistoricalDataModel` in `lib/features/crypto/data/models/`.
- [x] Implement `CryptoRemoteDataSource` using `dio` to connect to `freecryptoapi.io`.
- [x] Implement `CryptoRepositoryImpl`.
- [x] **Validation Phase**:
  - [x] Write unit tests for models and repository implementation.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: implement crypto data layer and API integration".
  - [ ] Wait for user approval.

## Phase 5: Domain & Data Layer (Portfolio)
- [x] Define `PortfolioItem` entity and model.
- [x] Set up Hive TypeAdapters for `PortfolioItem`.
- [x] Create `PortfolioRepository` interface and implementation.
- [x] Implement `PortfolioLocalDataSource` using `hive_ce`.
- [x] Implement Use Cases: `GetPortfolio`, `AddAsset`, `RemoveAsset`.
- [x] **Validation Phase**:
  - [x] Write unit tests for portfolio logic and Hive integration.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: implement portfolio domain and data layers with Hive".
  - [ ] Wait for user approval.

## Phase 6: Presentation Layer (BLoC)
- [x] Implement `CryptoBloc` for price tracking and list management.
- [x] Implement `ChartBloc` for historical data visualization logic.
- [x] Implement `PortfolioBloc` for managing user holdings.
- [x] **Validation Phase**:
  - [x] Write BLoC tests using `bloc_test`.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: implement presentation logic with BLoC".
  - [ ] Wait for user approval and `hot_reload`.

## Phase 7: UI Implementation (Screens & Charts)
- [x] Build `HomeScreen` with real-time coin list.
- [x] Build `DetailsScreen` with `fl_chart` for 24h, 7d, 30d, 1y views.
- [x] Build `PortfolioScreen` to view and manage assets.
- [x] Implement navigation using `Navigator` (or `go_router` if requested).
- [x] **Validation Phase**:
  - [x] Perform widget testing for key screens.
  - [x] Run `dart_fix`, `analyze_files`, `dart_format`.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "feat: implement UI screens and charts".
  - [ ] Wait for user approval and `hot_reload`.

## Phase 8: Final Polish & Documentation
- [ ] Create a comprehensive `README.md`.
- [ ] Create `GEMINI.md` describing the app, purpose, and file layout.
- [ ] Final visual audit of Dark/Light modes.
- [ ] Ask the user for final inspection and satisfaction.
- [ ] **Validation Phase**:
  - [ ] Final run of all tests and static analysis.
  - [ ] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "docs: finalize project documentation".
  - [ ] Wait for user approval.

---

*Note: After completing any task, if any TODOs are added to the code or anything is partially implemented, new tasks will be added to this plan to ensure completion.*

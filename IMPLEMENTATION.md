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
*   **2026-03-24**: Phase 5 completed. Implemented `WishlistItem` entity and `WishlistItemModel` with Hive annotations. Created `WishlistLocalDataSource` and `WishlistRepositoryImpl`. Implemented use cases for managing the wishlist. Generated Hive adapters and registered them in the injection container.
*   **2026-03-24**: Phase 6 completed. Implemented `CryptoBloc` for real-time tracking, `ChartBloc` for historical data, and `WishlistBloc` for favorite coins. Registered all Blocs as factories in the injection container.
*   **2026-03-24**: Phase 7 completed. Built the full UI including `HomeScreen` with real-time list, `DetailsScreen` with interactive `fl_chart`, and `WishlistScreen` for favorite coins tracking. Implemented Material 3 theming across all screens.
*   **2026-03-24**: Phase 8 completed. Finalized project documentation with comprehensive `README.md` and `GEMINI.md`. Performed a final visual audit and code cleanup. Verified architecture and file layout.
*   **2026-03-25**: Added unit tests for `CoinModel`, `GetTopCoins` UseCase, and Repository implementations (`CryptoRepositoryImpl`, `WishlistRepositoryImpl`). Verified all tests pass.

---

## Phase 1: Foundation & Project Setup
- [x] Create a Flutter package in the current directory using `create_project`.
- [x] Remove any boilerplate in the new package that will be replaced, including the `test` dir.
- [x] Update `pubspec.yaml`.
- [x] Update `README.md` with a placeholder description.
- [x] Create `CHANGELOG.md`.
- [x] Commit this empty version of the package.
- [x] Start running the app with `launch_app`.

## Phase 2: Core Architecture & Utilities
- [x] Define the project structure: `lib/core`, `lib/features`.
- [x] Implement `core/error/failures.dart` and `core/usecases/usecase.dart`.
- [x] Set up Dependency Injection with `get_it`.
- [x] Configure `core/theme/app_theme.dart`.

## Phase 3: Domain Layer (Coins & Historical Data)
- [x] Define `Coin` and `HistoricalData` entities.
- [x] Create `CryptoRepository` interface.
- [x] Implement Use Cases: `GetTopCoins`, `GetCoinDetails`, `GetHistoricalData`.

## Phase 4: Data Layer (Remote & API)
- [x] Create `CoinModel` and `HistoricalDataModel`.
- [x] Implement `CryptoRemoteDataSource` using `dio`.
- [x] Implement `CryptoRepositoryImpl`.

## Phase 5: Domain & Data Layer (Wishlist)
- [x] Define `WishlistItem` entity and model.
- [x] Set up Hive TypeAdapters for `WishlistItem`.
- [x] Create `WishlistRepository` interface and implementation.
- [x] Implement `WishlistLocalDataSource` using `hive_ce`.
- [x] Implement Use Cases: `GetWishlist`, `AddToWishlist`, `RemoveFromWishlist`.

## Phase 6: Presentation Layer (BLoC)
- [x] Implement `CryptoBloc`.
- [x] Implement `ChartBloc`.
- [x] Implement `WishlistBloc`.

## Phase 7: UI Implementation (Screens & Charts)
- [x] Build `HomeScreen`.
- [x] Build `DetailsScreen`.
- [x] Build `WishlistScreen`.
- [x] Implement navigation.

## Phase 8: Final Polish & Documentation
- [x] Create a comprehensive `README.md` file for the package.
- [x] Create a `GEMINI.md` file.
- [x] Ask the user for final inspection and satisfaction.
- [x] **Validation Phase**:
  - [x] Final run of all tests and static analysis.
  - [x] Update `IMPLEMENTATION.md` journal and check boxes.
  - [ ] `git diff` and commit with message "docs: finalize project documentation".
  - [ ] Wait for user approval.

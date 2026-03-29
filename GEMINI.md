# GEMINI.md - Development Insights

## Project Overview
CryptoVault is a cryptocurrency tracking application designed to demonstrate best-in-class Flutter development patterns as of 2026.

## Architecture & Design Decisions

### Clean Architecture (Feature-First)
The project is structured by feature to allow for independent scaling.
- `lib/core`: Shared utilities, error handling, and theme definitions.
- `lib/features/crypto`: The primary feature set including market data and wishlist management.

### BLoC Pattern
We used the **BLoC** pattern for state management to ensure a clear separation between UI events and business logic.
- `CryptoBloc`: Manages the market list and detailed coin data.
- `ChartBloc`: Handles the complexities of fetching and preparing historical data for visualization.
- `WishlistBloc`: Manages reactive updates to the user's favorite coins.

### Local-First with Hive
**Hive CE** was chosen for local storage due to its exceptional performance and simplicity when working with Dart objects. Wishlist items are persisted locally and updated reactively in the UI.

### Material 3 & Google Fonts
The app uses a centralized `AppTheme` using `ColorScheme.fromSeed` to ensure a cohesive Material 3 look across both Light and Dark modes.

## File Layout

```text
lib/
├── core/
│   ├── error/           # Failure classes
│   ├── theme/           # AppTheme (Material 3)
│   ├── usecases/        # Base UseCase interface
│   └── api_config.dart  # API configuration (gitignored)
├── features/crypto/
│   ├── data/            # Models, Repositories, DataSources
│   ├── domain/          # Entities, UseCase implementations
│   └── presentation/    # BLoCs, Pages, Widgets
├── injection_container.dart # Dependency Injection setup
└── main.dart            # App entry point & Bloc providers
```

## Future Enhancements
- [ ] Implement WebSockets for true real-time price updates.
- [ ] Add price alerts and push notifications.
- [ ] Integrate a search feature for the coin list.

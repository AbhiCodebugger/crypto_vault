# CryptoVault

A robust, real-time cryptocurrency price tracking and wishlist application built with Flutter.

## Features

- **Real-time Price Tracking**: Stay updated with the latest market data for top cryptocurrencies.
- **Historical Charts**: Visualize price trends over 24h, 7d, 30d, and 1y periods using interactive charts.
- **Wishlist**: Securely manage your favorite coins locally with Hive storage.
- **Material 3 UI**: Modern, accessible design with full support for Light and Dark modes.
- **Clean Architecture**: Built following SOLID principles for maximum maintainability and testability.

## Tech Stack

- **State Management**: BLoC (Business Logic Component)
- **Local Storage**: Hive CE (Community Edition)
- **Networking**: Dio
- **Dependency Injection**: GetIt
- **UI Components**: Material 3, fl_chart, Google Fonts

## Architecture

This project follows **Clean Architecture** principles, divided into three main layers:

1.  **Domain**: Contains Entities, Use Cases, and Repository Interfaces. (Pure Dart)
2.  **Data**: Implements Repository interfaces, manages Models (DTOs), and handles Data Sources (API/Hive).
3.  **Presentation**: UI Widgets and BLoCs.

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK

### Setup

1.  Clone the repository:
    ```bash
    git clone https://github.com/AbhiCodebugger/crypto_vault.git
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  **API Key Configuration**:
    - Create a file at `lib/core/api_config.dart`.
    - Add your API key from [freecryptoapi.io](https://freecryptoapi.com):
      ```dart
      class ApiConfig {
        static const String baseUrl = 'https://api.freecryptoapi.com/v1';
        static const String apiKey = 'YOUR_API_KEY_HERE';
      }
      ```
4.  Run the application:
    ```bash
    flutter run
    ```

## License

This project is licensed under the MIT License.

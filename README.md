# COVID-19 Tracker

A Flutter application for viewing worldwide and country-by-country COVID-19 statistics. The app uses a dark theme and presents the data through a global overview, searchable country list, and country detail pages.

## Features

- Animated splash screen
- Worldwide COVID-19 statistics
- Ring chart for total cases, recovered cases, and deaths
- Summary cards for active and critical cases
- Today's deaths and recoveries
- Searchable list of countries
- Country flags and country-specific statistics
- Loading indicators and shimmer placeholders while data is loading

## App flow

```text
Splash screen
    +-- World statistics
            +-- Countries list
                    +-- Country details
```

## Screens

### Splash screen

Displays the animated virus image and opens the world statistics screen after three seconds.

### World statistics

Loads the latest worldwide totals and displays:

- Total cases
- Deaths
- Active cases
- Critical cases
- Recovered cases
- Today's deaths
- Today's recovered cases

The screen also includes a chart and a button for opening the country list.

### Countries list

Loads country-level records, displays each country’s flag, and supports case-insensitive search by country name.

### Country details

Displays the selected country’s flag and detailed values for cases, tests, deaths, critical cases, recovered cases, and active cases.

## Data source

The app currently requests data from the [disease.sh API](https://disease.sh/):

- Worldwide totals: `https://disease.sh/v3/covid-19/all`
- Country list: `https://disease.sh/v3/covid-19/countries`

The API is accessed in [`lib/services/states_services.dart`](lib/services/states_services.dart), and the endpoint constants are defined in [`lib/services/utilities/app_url.dart`](lib/services/utilities/app_url.dart).

> The app depends on a third-party, live API. If the API is unavailable or changes its response format, data loading may fail.

## Technology

- [Flutter](https://flutter.dev/)
- Dart
- [`http`](https://pub.dev/packages/http) for API requests
- [`pie_chart`](https://pub.dev/packages/pie_chart) for the worldwide chart
- [`flutter_spinkit`](https://pub.dev/packages/flutter_spinkit) for loading animation
- [`shimmer`](https://pub.dev/packages/shimmer) for country-list placeholders
- [`animated_text_kit`](https://pub.dev/packages/animated_text_kit)

## Project structure

```text
lib/
+-- main.dart
+-- model/
|   +-- world_states_model.dart
+-- services/
|   +-- states_services.dart
|   +-- utilities/
|       +-- app_url.dart
+-- view/
    +-- countries_list_screen.dart
    +-- details_screen.dart
    +-- splash_screen.dart
    +-- world_states_screen.dart
assets/
└── images/
    └── virus.png
```

## Requirements

- Flutter SDK
- Dart SDK compatible with the constraint in [`pubspec.yaml`](pubspec.yaml)
- Android Studio, VS Code, or another Flutter-supported IDE
- An Android/iOS emulator or a connected physical device

## Getting started

Clone the repository:

```bash
git clone https://github.com/FAHIMSHAKIL102/flutter_covid19_app.git
cd flutter_covid19_app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Check connected devices with:

```bash
flutter devices
```

## Build

Build an Android APK:

```bash
flutter build apk
```

Build for iOS on macOS:

```bash
flutter build ios
```

## Development checks

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## License

No license has been specified for this repository. Add a license before distributing or reusing the project.

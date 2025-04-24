# FlexRise (FR) - Fitness Tracking App 💪

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

FlexRise is a fitness tracking application built with Flutter. It helps users log and analyze their workouts and meals, demonstrating state management (BLoC), local file storage (JSON), and REST API integration with a mock backend.

## Overview

FlexRise (FR) was developed as a class project to showcase core Flutter concepts while providing a practical tool for fitness enthusiasts. The app allows users to:

*   Track detailed exercise information (type, body parts, sets, reps, weight).
*   Log meals with nutritional data (type, time, carbs, fat, protein).
*   Visualize workout history on a color-coded calendar.
*   Analyze workout trends and daily nutrition via charts.
*   Ensure data persistence through local JSON files and synchronization with a mock API (MockAPI).

## Features

*   **Workout Logging:** Log exercises with details like type (e.g., Push-ups, Squats), body parts targeted (Chest, Back, etc.), sets, reps, and weight.
*   **Meal Logging:** Log meals with details like type (Breakfast, Lunch, etc.), time consumed, and nutrition facts (carbs, fat, protein in grams).
*   **Calendar View:** Displays logged days with color-coded markers based on body parts exercised (colors are mixed if multiple body parts were trained on the same day).
*   **Summary View:**
    *   Line chart for workout trends (view by exercise type, aggregated weekly or monthly).
    *   Pie chart for nutrition breakdown (carbs, fat, protein) for any selected day with logged meals.
*   **Data Persistence:** Saves user data locally using JSON files (`flexrise_data.json`).
*   **API Sync:** Optionally syncs data with a mock API service (MockAPI), falling back gracefully to local storage if the API is unavailable.

## Screenshots

| Adding Screen (Workout)                                                                          | Adding Screen (Meal)                                                                                 |
| :-----------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------: |
| ![Adding Screen - Workout] (screenshots/adding_screen_workout.png) | ![Adding Screen - Meal Details](https://raw.githubusercontent.com/stackeugene/flexrise/main/screenshots/adding_screen_meal_details.png) |

| Calendar Screen                                                                                    | Summary Screen (Workouts)                                                                              |
| :-------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: |
| ![Calendar Screen - Mixed Colors](https://raw.githubusercontent.com/stackeugene/flexrise/main/screenshots/calendar_screen_mixed_colors.png) | ![Summary Screen - Workouts](https://raw.githubusercontent.com/stackeugene/flexrise/main/screenshots/summary_screen_workouts.png) |

| Summary Screen (Nutrition)                                                                               |
| :-------------------------------------------------------------------------------------------------------: |
| ![Summary Screen - Nutrition Pie Chart](https://raw.githubusercontent.com/stackeugene/flexrise/main/screenshots/summary_screen_nutrition_pie.png) |

*(Note: Ensure the screenshot paths in the `main` branch of `stackeugene/flexrise` are correct for the images to display properly)*

## Prerequisites

Before running the app, ensure you have the following installed:

*   Flutter (version 3.0.0 or higher)
*   Dart (included with Flutter)
*   A code editor (e.g., VS Code with Flutter and Dart extensions)
*   A target device/emulator (Android/iOS) or Chrome for web deployment

## Setup Instructions

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/stackeugene/flexrise.git
    cd flexrise
    ```

2.  **Install Dependencies:** Run the following command to install the required packages:
    ```bash
    flutter pub get
    ```

3.  **Set Up MockAPI (Optional):**
    *   The app is configured to use a mock API for remote data storage via [MockAPI](https://mockapi.io/). You can create your own endpoint if desired.
    *   Update the `baseUrl` in `lib/services/api_service.dart` with your MockAPI project URL:
      ```dart
      // lib/services/api_service.dart
      final String baseUrl = 'https://your-mockapi-url.com'; // Replace with your URL
      ```
    *   If you skip this step or the API is unreachable, the app will default to using local JSON file storage.

4.  **Run the App:**
    *   **Web (Chrome):**
        ```bash
        flutter run -d chrome
        ```
    *   **Emulator or Physical Device:**
        ```bash
        flutter run
        ```

## Usage Guide

1.  **Login:**
    *   Use any email and password to log in. This is a dummy authentication screen for demonstration purposes.
2.  **Add a Workout:**
    *   Navigate to the "Add" tab.
    *   Select "Workout" from the type dropdown.
    *   Choose an exercise type, select the body part(s) targeted, and enter sets, reps, and weight.
    *   Tap "Save".
3.  **Add a Meal:**
    *   Navigate to the "Add" tab.
    *   Select "Meal" from the type dropdown.
    *   Specify the meal type (e.g., Breakfast), the time it was consumed, and the nutritional breakdown (carbs, fat, protein in grams).
    *   Tap "Save".
4.  **View Calendar:**
    *   Go to the "Calendar" tab.
    *   Days with logged workouts are marked with color-coded dots. Colors are mixed if multiple body parts were trained on the same day.
5.  **View Summary:**
    *   Go to the "Summary" tab.
    *   Select the "Workouts" sub-tab to view a line chart showing workout trends (can be filtered by exercise type and viewed weekly/monthly).
    *   Select the "Meals" sub-tab and choose a specific day from the dropdown to see a pie chart visualizing the macronutrient breakdown (carbs, fat, protein) for that day.

## Technical Details

### Tech Stack

*   **Framework:** Flutter (Dart)
*   **State Management:** `flutter_bloc` (BLoC pattern)
*   **Local Storage:** `path_provider` for accessing the file system, data stored in JSON format.
*   **API Communication:** `http` package for REST API calls to MockAPI.
*   **UI Components:**
    *   `table_calendar`: For the interactive calendar view.
    *   `fl_chart`: For creating the line (workout trends) and pie (nutrition breakdown) charts.

### Architecture

*   **State Management (BLoC):**
    *   `DataBloc`: Manages the application's state related to workouts and meals. It processes events like `AddWorkout`, `AddMeal`, `LoadData`, `FetchDataFromApi`, etc.
    *   `DataState`: Represents the current state, holding lists of `Workout` and `Meal` objects (`List<Workout>`, `List<Meal>`).
*   **File Support:**
    *   `FileService`: Handles reading from and writing data to a local JSON file (`flexrise_data.json`) in the application's documents directory.
*   **REST API Integration:**
    *   `ApiService`: Contains methods for interacting with the MockAPI backend (fetching and posting workout/meal data). Includes error handling and fallback logic to use `FileService` if API calls fail.
*   **Key Features Implementation:**
    *   **Color-Coded Calendar:** A custom algorithm determines the marker color for each day on the calendar based on the body parts trained. It mixes colors if multiple distinct body parts were targeted.
    *   **Nutrition Pie Chart:** Uses `fl_chart` to dynamically generate a pie chart representing the proportion of carbs, fat, and protein for a selected day's meals.

### Project Structure

```text
flex_rise/
├── lib/
│   ├── bloc/
│   │   └── data/               # BLoC related files
│   │       ├── data_bloc.dart
│   │       ├── data_event.dart
│   │       └── data_state.dart
│   ├── models/                 # Data models
│   │   ├── workout.dart
│   │   └── meal.dart
│   ├── screens/                # UI Screens
│   │   ├── adding_screen.dart
│   │   ├── calendar_screen.dart
│   │   └── summary_screen.dart
│   ├── services/               # Backend/Local services
│   │   ├── api_service.dart
│   │   └── file_service.dart
│   ├── widgets/                # Reusable UI Widgets (if any)
│   └── main.dart               # App entry point
├── screenshots/                # Application screenshots
│   ├── adding_screen_workout.png
│   ├── adding_screen_meal_details.png
│   ├── calendar_screen_mixed_colors.png
│   ├── summary_screen_workouts.png
│   └── summary_screen_nutrition_pie.png
├── pubspec.yaml                # Project dependencies and metadata
└── README.md                   # This file
FlexRise (FR) - Fitness Tracking App
Overview
FlexRise (FR) is a fitness tracking app built with Flutter, designed to help users log and analyze their workouts and meals. It was developed as a class project to demonstrate state management, file support, and REST API integration, while providing a user-friendly experience for fitness enthusiasts. The app allows users to track exercises, meals, and nutrition, visualize progress through charts, and ensure data persistence with local storage and a mock API.
Features

Workout Logging:
Log exercises with details like type (e.g., Push-ups, Squats), body parts targeted (Chest, Back, etc.), sets, reps, and weight.


Meal Logging:
Log meals with details like type (Breakfast, Lunch, etc.), time consumed, and nutrition facts (carbs, fat, protein in grams).


Calendar View:
Displays logged days with color-coded markers based on body parts exercised (mixed colors for multiple body parts).


Summary View:
Line chart for workout trends (by exercise type, week/month).
Pie chart for nutrition breakdown (carbs, fat, protein) on a selected day.


Data Persistence:
Saves data locally using JSON files.
Syncs with a mock API (MockAPI) with fallback to local storage if the API is unavailable.



Screenshots
Adding Screen (Workout)

Adding Screen (Meal)

Calendar Screen

Summary Screen (Workouts)

Summary Screen (Nutrition)

Prerequisites
Before running the app, ensure you have the following installed:

Flutter (version 3.0.0 or higher)
Dart (included with Flutter)
A code editor (e.g., VS Code with Flutter and Dart extensions)
A device/emulator or Chrome for web deployment

Setup Instructions

Clone the Repository:
git clone https://github.com/your-username/flexrise.git
cd flexrise


Install Dependencies:Run the following command to install the required packages:
flutter pub get


Set Up MockAPI (Optional):

The app uses a mock API for remote data storage. You can create your own mock API using MockAPI.
Update the baseUrl in lib/services/api_service.dart with your MockAPI URL:final String baseUrl = 'https://your-mockapi-url.com';


If you skip this step, the app will fall back to local storage.


Run the App:

To run on Chrome (web):flutter run -d chrome


To run on an emulator or physical device:flutter run





Usage Guide

Login:

Use any email and password to log in (dummy authentication for demo purposes).


Add a Workout:

Go to the "Add" tab.
Select "Workout" as the type.
Choose an exercise type, body parts targeted, sets, reps, and weight.
Save the entry.


Add a Meal:

Go to the "Add" tab.
Select "Meal" as the type.
Specify the meal type (e.g., Breakfast), time consumed, and nutrition facts (carbs, fat, protein).
Save the entry.


View Calendar:

Go to the "Calendar" tab.
Days with logged workouts are marked with color-coded dots (colors mix for multiple body parts).


View Summary:

Go to the "Summary" tab.
Select "Workouts" to see a line chart of your workout trends.
Select "Meals" and choose a day to see a pie chart of your nutrition breakdown.



Technical Details
Tech Stack

Framework: Flutter (Dart)
State Management: flutter_bloc (BLoC pattern)
File Storage: path_provider for local JSON storage
REST API: http package for MockAPI integration
UI Components:
table_calendar for the calendar view
fl_chart for line and pie charts



Architecture

State Management:
DataBloc manages the app state, handling events like AddWorkout, AddMeal, and LoadData.
DataState stores the app’s data (List<Workout> and List<Meal>).


File Support:
FileService handles reading/writing data to a local JSON file (flexrise_data.json).


REST API:
ApiService makes HTTP requests to a mock API for fetching and adding workouts/meals.
Fallback to local storage if the API fails.


Key Features:
Color-coded calendar markers using a custom color-mixing algorithm.
Nutrition pie chart for visualizing carbs, fat, and protein.



Project Structure
flex_rise/
├── lib/
│   ├── bloc/
│   │   ├── data/
│   │   │   ├── data_bloc.dart
│   │   │   ├── data_event.dart
│   │   │   └── data_state.dart
│   ├── models/
│   │   ├── workout.dart
│   │   └── meal.dart
│   ├── screens/
│   │   ├── adding_screen.dart
│   │   ├── calendar_screen.dart
│   │   └── summary_screen.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── file_service.dart
│   └── main.dart
├── screenshots/
│   ├── adding_screen_workout.png
│   ├── adding_screen_meal_details.png
│   ├── calendar_screen_mixed_colors.png
│   ├── summary_screen_workouts.png
│   └── summary_screen_nutrition_pie.png
├── pubspec.yaml
└── README.md

Challenges and Solutions

Bottom Overflow Error:
Fixed by wrapping the AddingScreen in a SingleChildScrollView.


Type Safety Issues:
Ensured proper typing in DataState (List<Workout> and List<Meal>) and fixed missing imports.


Complex Features:
Implemented a color-mixing algorithm for the calendar markers and a pie chart for nutrition using fl_chart.



Future Enhancements

Add real user authentication (e.g., Firebase).
Implement a goals feature (e.g., weekly workout or nutrition goals).
Enhance analytics with trends over longer periods.
Improve UI/UX with animations and better styling.

Contributing
Contributions are welcome! To contribute:

Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Make your changes and commit (git commit -m "Add your feature").
Push to your branch (git push origin feature/your-feature).
Open a Pull Request.

Please ensure your code follows the existing style and includes tests if applicable.
License
This project is licensed under the MIT License - see the LICENSE file for details.
Contact
For questions or feedback, reach out to me at your-email@example.com or open an issue on GitHub.

Happy tracking with FlexRise! 💪

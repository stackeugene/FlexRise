import '../../models/workout.dart';
import '../../models/meal.dart';

class DataState {
  final List<Workout> workouts;
  final List<Meal> meals;

  DataState({
    required this.workouts,
    required this.meals,
  });

  factory DataState.initial() => DataState(
        workouts: [],
        meals: [],
      );

  DataState copyWith({
    List<Workout>? workouts,
    List<Meal>? meals,
  }) {
    return DataState(
      workouts: workouts ?? this.workouts,
      meals: meals ?? this.meals,
    );
  }
}
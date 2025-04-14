import 'package:equatable/equatable.dart';
import '../../models/workout.dart';
import '../../models/meal.dart';

class DataState extends Equatable {
  final List<Workout> workouts;
  final List<Meal> meals;

  const DataState({
    this.workouts = const [], // Ensure const default value
    this.meals = const [], // Ensure const default value
  });

  DataState copyWith({
    List<Workout>? workouts,
    List<Meal>? meals,
  }) {
    return DataState(
      workouts: workouts ?? this.workouts,
      meals: meals ?? this.meals,
    );
  }

  @override
  List<Object> get props => [workouts, meals];
}
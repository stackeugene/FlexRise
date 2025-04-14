import 'package:equatable/equatable.dart';
import '../../models/workout.dart';
import '../../models/meal.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class AddWorkout extends DataEvent {
  final Workout workout;

  const AddWorkout(this.workout);

  @override
  List<Object> get props => [workout];
}

class AddMeal extends DataEvent {
  final Meal meal;

  const AddMeal(this.meal);

  @override
  List<Object> get props => [meal];
}

class LoadData extends DataEvent {}
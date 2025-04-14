import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_rise/models/workout.dart';
import 'package:flex_rise/models/meal.dart';
import 'package:flex_rise/services/file_service.dart';
import 'package:flex_rise/services/api_service.dart';
import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final FileService _fileService = FileService();
  final ApiService _apiService = ApiService();

  DataBloc() : super(const DataState()) {
    on<AddWorkout>((event, emit) async {
      final updatedWorkouts = List<Workout>.from(state.workouts)..add(event.workout);
      emit(state.copyWith(workouts: updatedWorkouts));
      try {
        await _apiService.addWorkout(event.workout);
      } catch (e) {
        // Fallback to file storage if API fails
        await _fileService.writeData(updatedWorkouts, state.meals);
      }
    });

    on<AddMeal>((event, emit) async {
      final updatedMeals = List<Meal>.from(state.meals)..add(event.meal);
      emit(state.copyWith(meals: updatedMeals));
      try {
        await _apiService.addMeal(event.meal);
      } catch (e) {
        // Fallback to file storage if API fails
        await _fileService.writeData(state.workouts, updatedMeals);
      }
    });

    on<LoadData>((event, emit) async {
      try {
        final workouts = await _apiService.fetchWorkouts();
        final meals = await _apiService.fetchMeals();
        emit(state.copyWith(workouts: workouts, meals: meals));
        // Sync with file storage
        await _fileService.writeData(workouts, meals);
      } catch (e) {
        // Fallback to file storage if API fails
        final data = await _fileService.readData();
        final workouts = (data['workouts'] as List)
            .map((json) => Workout.fromJson(json))
            .toList();
        final meals = (data['meals'] as List)
            .map((json) => Meal.fromJson(json))
            .toList();
        emit(state.copyWith(workouts: workouts, meals: meals));
      }
    });

    // Load data when the BLoC is created
    add(const LoadData());
  }
}
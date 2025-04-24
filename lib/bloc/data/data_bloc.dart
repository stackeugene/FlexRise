import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_rise/services/api_service.dart';
import 'package:flex_rise/services/file_service.dart';
import 'data_event.dart';
import 'data_state.dart';
import '../../models/workout.dart'; // Add this import
import '../../models/meal.dart'; // Add this import

class DataBloc extends Bloc<DataEvent, DataState> {
  final FileService _fileService;
  final ApiService _apiService;

  DataBloc({FileService? fileService, ApiService? apiService})
      : _fileService = fileService ?? FileService(),
        _apiService = apiService ?? ApiService(),
        super(DataState.initial()) {
    on<LoadData>(_onLoadData);
    on<AddWorkout>(_onAddWorkout);
    on<AddMeal>(_onAddMeal);
  }

  Future<void> _onLoadData(LoadData event, Emitter<DataState> emit) async {
    try {
      final workouts = await _apiService.fetchWorkouts();
      final meals = await _apiService.fetchMeals();
      emit(state.copyWith(workouts: workouts, meals: meals));
    } catch (e) {
      final data = await _fileService.readData();
      emit(state.copyWith(workouts: data['workouts'] ?? [], meals: data['meals'] ?? []));
    }
  }

  Future<void> _onAddWorkout(AddWorkout event, Emitter<DataState> emit) async {
    final updatedWorkouts = List<Workout>.from(state.workouts)..add(event.workout);
    emit(state.copyWith(workouts: updatedWorkouts));

    try {
      await _apiService.addWorkout(event.workout);
    } catch (e) {
      await _fileService.writeData({
        'workouts': updatedWorkouts,
        'meals': state.meals,
      });
    }
  }

  Future<void> _onAddMeal(AddMeal event, Emitter<DataState> emit) async {
    final updatedMeals = List<Meal>.from(state.meals)..add(event.meal);
    emit(state.copyWith(meals: updatedMeals));

    try {
      await _apiService.addMeal(event.meal);
    } catch (e) {
      await _fileService.writeData({
        'workouts': state.workouts,
        'meals': updatedMeals,
      });
    }
  }
}
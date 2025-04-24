import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/workout.dart';
import '../models/meal.dart';

class ApiService {
  final String baseUrl = 'https://mockapi.example.com'; // Replace with your MockAPI URL

  Future<List<Workout>> fetchWorkouts() async {
    final response = await http.get(Uri.parse('$baseUrl/workouts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch workouts');
    }
  }

  Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse('$baseUrl/meals'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  Future<void> addWorkout(Workout workout) async {
    final response = await http.post(
      Uri.parse('$baseUrl/workouts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(workout.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add workout');
    }
  }

  Future<void> addMeal(Meal meal) async {
    final response = await http.post(
      Uri.parse('$baseUrl/meals'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(meal.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add meal');
    }
  }
}
import 'package:flutter/material.dart'; // Add this import for TimeOfDay

class Meal {
  final DateTime date;
  final String type;
  final String mealType;
  final TimeOfDay timeConsumed;
  final double carbs;
  final double fat;
  final double protein;

  Meal({
    required this.date,
    required this.type,
    required this.mealType,
    required this.timeConsumed,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
        'mealType': mealType,
        'timeConsumed': '${timeConsumed.hour}:${timeConsumed.minute}',
        'carbs': carbs,
        'fat': fat,
        'protein': protein,
      };

  factory Meal.fromJson(Map<String, dynamic> json) {
    final timeParts = (json['timeConsumed'] as String).split(':');
    return Meal(
      date: DateTime.parse(json['date']),
      type: json['type'],
      mealType: json['mealType'] ?? 'Unknown',
      timeConsumed: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      carbs: json['carbs']?.toDouble() ?? 0.0,
      fat: json['fat']?.toDouble() ?? 0.0,
      protein: json['protein']?.toDouble() ?? 0.0,
    );
  }
}
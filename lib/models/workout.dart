class Workout {
  final DateTime date;
  final String type;
  final String exerciseType;
  final List<String> bodyParts; // List to support multiple body parts
  final int sets;
  final int repetitions;
  final double? weight;

  Workout({
    required this.date,
    required this.type,
    required this.exerciseType,
    required this.bodyParts,
    required this.sets,
    required this.repetitions,
    this.weight,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
        'exerciseType': exerciseType,
        'bodyParts': bodyParts,
        'sets': sets,
        'repetitions': repetitions,
        'weight': weight,
      };

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        date: DateTime.parse(json['date']),
        type: json['type'],
        exerciseType: json['exerciseType'] ?? 'Unknown', // Add default value for backward compatibility
        bodyParts: json['bodyParts'] != null ? List<String>.from(json['bodyParts']) : [], // Add default for backward compatibility
        sets: json['sets'],
        repetitions: json['repetitions'],
        weight: json['weight']?.toDouble(),
      );  
} 
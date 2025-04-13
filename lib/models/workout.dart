class Workout {
  final DateTime date;
  final String type;
  final int sets;
  final int repetitions;

  Workout({
    required this.date,
    required this.type,
    required this.sets,
    required this.repetitions,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
        'sets': sets,
        'repetitions': repetitions,
      };

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        date: DateTime.parse(json['date']),
        type: json['type'],
        sets: json['sets'],
        repetitions: json['repetitions'],
      );
}
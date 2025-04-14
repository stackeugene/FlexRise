class Meal {
  final DateTime date;
  final String type;

  Meal({
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
      };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        date: DateTime.parse(json['date']),
        type: json['type'],
      );
}
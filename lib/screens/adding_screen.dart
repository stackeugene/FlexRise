import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../bloc/data/data_bloc.dart';
import '../bloc/data/data_event.dart';
import '../models/workout.dart';
import '../models/meal.dart';

class AddingScreen extends StatefulWidget {
  const AddingScreen({super.key});

  @override
  _AddingScreenState createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  DateTime _selectedDay = DateTime.now();
  String _type = 'Workout';
  String _exerciseType = 'Push-ups';
  String _customExercise = '';
  List<String> _selectedBodyParts = [];
  int _sets = 1;
  int _repetitions = 1;
  double? _weight;
  String _mealType = 'Breakfast'; // Default meal type
  TimeOfDay _timeConsumed = TimeOfDay.now(); // Default to current time
  double _carbs = 0.0;
  double _fat = 0.0;
  double _protein = 0.0;

  final List<String> _exerciseTypes = [
    'Push-ups',
    'Squats',
    'Running',
    'Pull-ups',
    'Sit-ups',
    'Custom',
  ];

  final List<String> _bodyParts = [
    'Chest',
    'Back',
    'Biceps',
    'Triceps',
    'Legs',
    'Shoulders',
  ];

  final List<String> _mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeConsumed,
    );
    if (picked != null && picked != _timeConsumed) {
      setState(() {
        _timeConsumed = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adding Workout/Meal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Date'),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Type'),
            DropdownButton<String>(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'Workout', child: Text('Workout')),
                DropdownMenuItem(value: 'Meal', child: Text('Meal')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            if (_type == 'Workout') ...[
              const SizedBox(height: 16),
              const Text('Exercise Type'),
              DropdownButton<String>(
                value: _exerciseType,
                items: _exerciseTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _exerciseType = value!;
                    if (_exerciseType != 'Custom') {
                      _customExercise = '';
                    }
                  });
                },
              ),
              if (_exerciseType == 'Custom') ...[
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Custom Exercise',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _customExercise = value;
                    });
                  },
                ),
              ],
              const SizedBox(height: 16),
              const Text('Body Parts Targeted'),
              Wrap(
                spacing: 8.0,
                children: _bodyParts.map((bodyPart) {
                  return FilterChip(
                    label: Text(bodyPart),
                    selected: _selectedBodyParts.contains(bodyPart),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedBodyParts.add(bodyPart);
                        } else {
                          _selectedBodyParts.remove(bodyPart);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Sets'),
              DropdownButton<int>(
                value: _sets,
                items: List.generate(10, (index) => index + 1)
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sets = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Repetitions'),
              DropdownButton<int>(
                value: _repetitions,
                items: List.generate(20, (index) => index + 1)
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _repetitions = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Weight Used (kg)'),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter weight (optional)',
                ),
                onChanged: (value) {
                  setState(() {
                    _weight = value.isEmpty ? null : double.tryParse(value);
                  });
                },
              ),
            ],
            if (_type == 'Meal') ...[
              const SizedBox(height: 16),
              const Text('Meal Type'),
              DropdownButton<String>(
                value: _mealType,
                items: _mealTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _mealType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Time Consumed'),
              Row(
                children: [
                  Text(
                    _timeConsumed.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Nutrition Facts (grams)'),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Carbs (g)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter carbs in grams',
                ),
                onChanged: (value) {
                  setState(() {
                    _carbs = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Fat (g)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter fat in grams',
                ),
                onChanged: (value) {
                  setState(() {
                    _fat = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Protein (g)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter protein in grams',
                ),
                onChanged: (value) {
                  setState(() {
                    _protein = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_type == 'Workout') {
                  final exercise = _exerciseType == 'Custom' ? _customExercise : _exerciseType;
                  if (exercise.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select or enter an exercise type')),
                    );
                    return;
                  }
                  if (_selectedBodyParts.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select at least one body part')),
                    );
                    return;
                  }
                  context.read<DataBloc>().add(
                        AddWorkout(
                          Workout(
                            date: _selectedDay,
                            type: _type,
                            exerciseType: exercise,
                            bodyParts: _selectedBodyParts,
                            sets: _sets,
                            repetitions: _repetitions,
                            weight: _weight,
                          ),
                        ),
                      );
                } else {
                  if (_carbs + _fat + _protein == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter at least one nutrition value')),
                    );
                    return;
                  }
                  context.read<DataBloc>().add(
                        AddMeal(
                          Meal(
                            date: _selectedDay,
                            type: _type,
                            mealType: _mealType,
                            timeConsumed: _timeConsumed,
                            carbs: _carbs,
                            fat: _fat,
                            protein: _protein,
                          ),
                        ),
                      );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Entry Saved!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
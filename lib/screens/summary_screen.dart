import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../bloc/data/data_bloc.dart';
import '../bloc/data/data_state.dart';
import '../models/workout.dart';
import '../models/meal.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String _view = 'Week';
  String _dataType = 'Workouts';
  String? _selectedExerciseType;
  DateTime _selectedNutritionDay = DateTime.now();

  List<FlSpot> _getSpots(List<Workout> data, bool isWeek) {
    final now = DateTime.now();
    final startDate = isWeek
        ? now.subtract(const Duration(days: 6))
        : now.subtract(const Duration(days: 29));
    final spots = <FlSpot>[];

    for (int i = 0; i < (isWeek ? 7 : 30); i++) {
      final day = startDate.add(Duration(days: i));
      final count = data
          .where((entry) =>
              entry.date.day == day.day &&
              entry.date.month == day.month &&
              entry.date.year == day.year &&
              (_selectedExerciseType == null || entry.exerciseType == _selectedExerciseType))
          .length;
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }

    return spots;
  }

  List<String> _getExerciseTypes(List<Workout> workouts) {
    final types = workouts.map((entry) => entry.exerciseType).toSet().toList();
    types.sort();
    return ['All', ...types];
  }

  Map<String, double> _calculateNutrition(List<Meal> meals, DateTime selectedDay) {
    final mealsOnDay = meals.where((meal) =>
        meal.date.day == selectedDay.day &&
        meal.date.month == selectedDay.month &&
        meal.date.year == selectedDay.year).toList();

    double totalCarbs = 0.0;
    double totalFat = 0.0;
    double totalProtein = 0.0;

    for (var meal in mealsOnDay) {
      totalCarbs += meal.carbs;
      totalFat += meal.fat;
      totalProtein += meal.protein;
    }

    return {
      'Carbs': totalCarbs,
      'Fat': totalFat,
      'Protein': totalProtein,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        final List<FlSpot> spots = _dataType == 'Workouts' ? _getSpots(state.workouts, _view == 'Week') : [];
        final exerciseTypes = _dataType == 'Workouts' ? _getExerciseTypes(state.workouts) : ['All'];
        final nutritionData = _dataType == 'Meals' ? _calculateNutrition(state.meals, _selectedNutritionDay) : {};

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (_dataType == 'Workouts') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: _view,
                        items: const [
                          DropdownMenuItem(value: 'Week', child: Text('Week')),
                          DropdownMenuItem(value: 'Month', child: Text('Month')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _view = value!;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        value: _dataType,
                        items: const [
                          DropdownMenuItem(value: 'Workouts', child: Text('Workouts')),
                          DropdownMenuItem(value: 'Meals', child: Text('Meals')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dataType = value!;
                            _selectedExerciseType = null;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_dataType == 'Workouts') ...[
                    const SizedBox(height: 16),
                    const Text('Exercise Type'),
                    DropdownButton<String>(
                      value: _selectedExerciseType ?? 'All',
                      items: exerciseTypes
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedExerciseType = value == 'All' ? null : value;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true),
                        titlesData: const FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        minX: 0,
                        maxX: _view == 'Week' ? 6 : 29,
                        minY: 0,
                        maxY: 10,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.blue,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (_dataType == 'Meals') ...[
                  DropdownButton<String>(
                    value: _dataType,
                    items: const [
                      DropdownMenuItem(value: 'Workouts', child: Text('Workouts')),
                      DropdownMenuItem(value: 'Meals', child: Text('Meals')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _dataType = value!;
                        _selectedExerciseType = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Day for Nutrition Breakdown'),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _selectedNutritionDay,
                    calendarFormat: CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedNutritionDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedNutritionDay = selectedDay;
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
                  const Text('Nutrition Breakdown (grams)'),
                  if (nutritionData['Carbs']! + nutritionData['Fat']! + nutritionData['Protein']! > 0) ...[
                    SizedBox(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: nutritionData['Carbs'],
                              title: 'Carbs\n${nutritionData['Carbs']!.toStringAsFixed(1)}g',
                              color: Colors.blue,
                              radius: 100,
                            ),
                            PieChartSectionData(
                              value: nutritionData['Fat'],
                              title: 'Fat\n${nutritionData['Fat']!.toStringAsFixed(1)}g',
                              color: Colors.red,
                              radius: 100,
                            ),
                            PieChartSectionData(
                              value: nutritionData['Protein'],
                              title: 'Protein\n${nutritionData['Protein']!.toStringAsFixed(1)}g',
                              color: Colors.green,
                              radius: 100,
                            ),
                          ],
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ] else ...[
                    const Text('No meals logged on this day.'),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
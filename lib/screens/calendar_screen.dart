import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data/data_bloc.dart';
import '../bloc/data/data_state.dart';
import 'adding_screen.dart';
import 'summary_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedIndex = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  static const List<Widget> _screens = <Widget>[
    CalendarView(),
    AddingScreen(),
    SummaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexRise - Calendar'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<String, Color> _bodyPartColors = {
    'Chest': Colors.red,
    'Back': Colors.blue,
    'Biceps': Colors.green,
    'Triceps': Colors.orange,
    'Legs': Colors.purple,
    'Shoulders': Colors.yellow,
  };

  Color _mixColors(List<Color> colors) {
    if (colors.isEmpty) return Colors.grey;
    if (colors.length == 1) return colors.first;

    double r = 0, g = 0, b = 0;
    for (var color in colors) {
      r += color.red / colors.length;
      g += color.green / colors.length;
      b += color.blue / colors.length;
    }
    return Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
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
                formatButtonVisible: true,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final workouts = state.workouts.where((workout) =>
                      workout.date.day == date.day &&
                      workout.date.month == date.month &&
                      workout.date.year == date.year).toList();

                  if (workouts.isEmpty) return null;

                  final bodyParts = workouts
                      .expand((workout) => workout.bodyParts)
                      .toSet()
                      .toList();

                  final colors = bodyParts
                      .map((part) => _bodyPartColors[part] ?? Colors.grey)
                      .toList();

                  final mixedColor = _mixColors(colors);

                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: mixedColor,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<CalendarFormat>(
              value: _calendarFormat,
              items: const [
                DropdownMenuItem(
                  value: CalendarFormat.month,
                  child: Text('Month'),
                ),
                DropdownMenuItem(
                  value: CalendarFormat.week,
                  child: Text('Week'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _calendarFormat = value!;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
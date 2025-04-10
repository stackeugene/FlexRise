import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AddingScreen extends StatefulWidget {
  const AddingScreen({super.key});

  @override
  _AddingScreenState createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  DateTime _selectedDay = DateTime.now();
  String _type = 'Workout';
  int _sets = 1;
  int _repetitions = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save the entry (placeholder for now)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Entry Saved!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
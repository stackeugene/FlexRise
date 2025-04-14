import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/data/data_bloc.dart';
import '../bloc/data/data_state.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String _view = 'Week';
  String _dataType = 'Workouts';

  List<FlSpot> _getSpots(List<dynamic> data, bool isWeek) {
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
              entry.date.year == day.year)
          .length;
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        final data = _dataType == 'Workouts' ? state.workouts : state.meals;
        final spots = _getSpots(data, _view == 'Week');

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
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
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
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
          ),
        );
      },
    );
  }
}
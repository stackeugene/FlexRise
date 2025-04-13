import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/workout.dart';
import '../models/meal.dart';

class FileService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/flexrise_data.json');
  }

  Future<Map<String, dynamic>> readData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents);
      }
      return {'workouts': [], 'meals': []};
    } catch (e) {
      return {'workouts': [], 'meals': []};
    }
  }

  Future<void> writeData(List<Workout> workouts, List<Meal> meals) async {
    final file = await _localFile;
    final data = {
      'workouts': workouts.map((w) => w.toJson()).toList(),
      'meals': meals.map((m) => m.toJson()).toList(),
    };
    await file.writeAsString(jsonEncode(data));
  }
}
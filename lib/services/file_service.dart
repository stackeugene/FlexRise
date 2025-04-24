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
      final contents = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(contents);
      return {
        'workouts': (data['workouts'] as List<dynamic>?)
                ?.map((e) => Workout.fromJson(e))
                .toList() ??
            [],
        'meals': (data['meals'] as List<dynamic>?)
                ?.map((e) => Meal.fromJson(e))
                .toList() ??
            [],
      };
    } catch (e) {
      return {'workouts': [], 'meals': []};
    }
  }

  Future<void> writeData(Map<String, dynamic> data) async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode(data));
  }
}
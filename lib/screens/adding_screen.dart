import 'package:flutter/material.dart';

class AddingScreen extends StatelessWidget {
  const AddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexRise - Add Workout/Meal'),
      ),
      body: const Center(
        child: Text('Adding Screen - Placeholder'),
      ),
    );
  }
}
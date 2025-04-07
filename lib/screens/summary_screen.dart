import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexRise - Summary'),
      ),
      body: const Center(
        child: Text('Summary Chart (Week/Month) - Placeholder'),
      ),
    );
  }
}
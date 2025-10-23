import 'package:flutter/material.dart';

class LearnerSearchScreen extends StatelessWidget {
  const LearnerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Text('Search Screen', style: TextTheme.of(context).headlineLarge),
      ),
    );
  }
}
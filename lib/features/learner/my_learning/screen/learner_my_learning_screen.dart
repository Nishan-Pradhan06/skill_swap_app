import 'package:flutter/material.dart';

class LearnerMyLearningScreen extends StatelessWidget {
  const LearnerMyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'My Learning Screen',
          style: TextTheme.of(context).headlineLarge,
        ),
      ),
    );
  }
}

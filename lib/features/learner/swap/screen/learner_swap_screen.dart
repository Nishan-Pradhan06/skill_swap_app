import 'package:flutter/material.dart';

class LearnerSwapScreen extends StatelessWidget {
  const LearnerSwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Swap Screen', style: TextTheme.of(context).headlineLarge),
      ),
    );
  }
}

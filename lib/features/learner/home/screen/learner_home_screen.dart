import 'package:flutter/material.dart';

class LearnerHomeScreen extends StatelessWidget {
  const LearnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: TextTheme.of(context).headlineLarge),
      ),
    );
  }
}

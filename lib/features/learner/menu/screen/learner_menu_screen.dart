import 'package:flutter/material.dart';

class LearnerMenuScreen extends StatelessWidget {
  const LearnerMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Text('Menu Screen', style: TextTheme.of(context).headlineLarge),
      ),
    );
  }
}
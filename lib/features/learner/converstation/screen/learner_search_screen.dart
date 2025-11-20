import 'package:flutter/material.dart';

class ConverstationScreen extends StatelessWidget {
  const ConverstationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: Text('Chat Screen', style: TextTheme.of(context).headlineLarge),
      ),
    );
  }
}

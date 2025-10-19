import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key});

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _dotAnimation = StepTween(begin: 0, end: 4).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotAnimation,
      builder: (context, child) {
        String dots = "." * _dotAnimation.value;
        return Text("Loading$dots", style: const TextStyle(fontSize: 20));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

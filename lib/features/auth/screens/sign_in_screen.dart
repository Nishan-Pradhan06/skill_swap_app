import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_background.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(child: CustomPadding(child: Column())),
      ),
    );
  }
}

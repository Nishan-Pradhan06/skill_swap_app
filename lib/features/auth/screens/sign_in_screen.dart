import 'package:flutter/material.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPadding(
          vertical: 50,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              Text(
                'WELCOME TO\nSKILL SWAP',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: darkTextTheme
                      ? AppTheme.textSecondaryDark
                      : AppTheme.surfaceDark,
                ),
              ),
              Text(
                'Continue to SignIn',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 50),

              CustomTextField(
                hint: 'Email Address',
                borderColor: Colors.transparent,
                type: CustomTextFieldType.email,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              CustomTextField(
                hint: 'Password',
                borderColor: Colors.transparent,
                type: CustomTextFieldType.password,
                obscureText: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password?',
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              CustomButton(text: 'Sign In', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

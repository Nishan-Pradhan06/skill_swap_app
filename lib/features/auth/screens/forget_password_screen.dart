import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';

import '../../../core/helpers/validation_helpers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPadding(
          vertical: 50,
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'FORGET\nPASSWORD?',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: darkTextTheme
                                ? AppTheme.textSecondaryDark
                                : AppTheme.surfaceDark,
                          ),
                    ),
                    Text(
                      'Enter email address to get code.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CustomTextField(
                  hint: 'Email Address',
                  controller: _emailController,
                  borderColor: Colors.transparent,
                  validator: InputValidator.validateEmail,

                  type: CustomTextFieldType.email,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),

                CustomButton(
                  text: 'Get Code',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

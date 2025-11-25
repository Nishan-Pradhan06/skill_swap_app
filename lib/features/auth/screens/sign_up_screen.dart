import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:skill_swap/features/auth/models/sign_up_model.dart';
import 'package:skill_swap/features/device_register_push_notification/bloc/device_register/device_register_bloc.dart';

import '../../../core/helpers/validation_helpers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../router/app_routes_names.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                      'WELCOME TO\nSKILL SWAP',
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
                      'Continue to Sign up',
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
                CustomTextField(
                  hint: 'Password',
                  controller: _passwordController,
                  borderColor: Colors.transparent,
                  type: CustomTextFieldType.password,
                  validator: InputValidator.validatePassword,
                  obscureText: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),
                CustomTextField(
                  hint: 'Confirm Password',
                  controller: _confirmPasswordController,
                  borderColor: Colors.transparent,
                  type: CustomTextFieldType.password,
                  validator: (value) => InputValidator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  obscureText: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),

                BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      failure: (failure) {
                        CustomToast.showError(failure.message);
                      },
                      loaded: (data) {
                        context.goNamed(AppRoutesName.profileSetupScreenRoute);
                        CustomToast.showSuccess("Register Successful !!!");
                        sl<DeviceRegisterBloc>().add(
                          DeviceRegisterEvent.deviceRegister(),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    final bool isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return CustomButton(
                      text: 'Sign Up',
                      isDisabled: isLoading,
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sl<SignUpBloc>().add(
                            SignUpEvent.signUp(
                              SignUpModel(
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                              ),
                            ),
                          );
                        }
                      },
                    );
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

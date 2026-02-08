import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/auth/bloc/forgot_password/reset_password_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:skill_swap/core/helpers/validation_helpers.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPadding(
          vertical: 40,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Enter your new password below.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: 'New Password',
                    controller: _passwordController,
                    validator: InputValidator.validatePassword,
                    type: CustomTextFieldType.password,
                    obscureText: true,
                  ),
                  CustomTextField(
                    hint: 'Confirm Password',
                    controller: _confirmPasswordController,
                    validator: (value) =>
                        InputValidator.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                    type: CustomTextFieldType.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        loaded: (message) {
                          CustomToast.showSuccess(message);
                          context.goNamed(AppRoutesName.authSignInScreenRoute);
                        },
                        failure: (failure) {
                          CustomToast.showError(failure.message);
                        },
                      );
                    },
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        isLoading: isLoading,
                        text: "Update Password",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ResetPasswordBloc>().add(
                              ResetPasswordEvent.reset(
                                email: widget.email,
                                code: widget.code,
                                newPassword: _passwordController.text.trim(),
                                confirmPassword: _confirmPasswordController.text
                                    .trim(),
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
      ),
    );
  }
}

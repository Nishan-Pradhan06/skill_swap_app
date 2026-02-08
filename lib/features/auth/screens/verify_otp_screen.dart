import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/core/widgets/double_press_to_exit.dart';
import 'package:skill_swap/features/auth/bloc/forgot_password/verify_otp_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:skill_swap/core/helpers/validation_helpers.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    return DoubleBackToExit(
      child: Scaffold(
        body: SafeArea(
          child: CustomPadding(
            vertical: 40,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Verify Your Email",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    'We have sent an OTP to ${widget.email}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  Pinput(
                    length: 6,
                    controller: _otpController,
                    validator: InputValidator.validateOtp,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: AppTheme.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        loaded: (message) {
                          CustomToast.showSuccess(message);
                          context.pushNamed(
                            AppRoutesName.authResetPasswordScreenRoute,
                            extra: {
                              'email': widget.email,
                              'code': _otpController.text.trim(),
                            },
                          );
                        },
                        failure: (failure) {
                          CustomToast.showError(failure.message);
                        },
                      );
                    },
                    builder: (context, state) {
                      final bool isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        isLoading: isLoading,
                        text: "Continue",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<VerifyOtpBloc>().add(
                              VerifyOtpEvent.verifyOTP(
                                email: widget.email,
                                otp: _otpController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Please wait for 60 sec to request for another PIN code.",
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

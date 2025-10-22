import 'package:flutter/material.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';

import '../../../core/helpers/validation_helpers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleBiometricAuth() async {
    setState(() {});

    // Simulate biometric authentication
    await Future.delayed(const Duration(seconds: 2));

    setState(() {});

    if (mounted) {
      CustomToast.showSuccess('Biometric Authentication Successful');
    }
  }

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
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Continue to SignIn',
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
                  borderColor: Colors.transparent,
                  type: CustomTextFieldType.email,
                  validator: InputValidator.validateEmail,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),
                CustomTextField(
                  hint: 'Password',
                  borderColor: Colors.transparent,
                  type: CustomTextFieldType.password,
                  validator: InputValidator.validatePassword,
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

                CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),

                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextTheme.of(
                          context,
                        ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Biometric Button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleBiometricAuth,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Fingerprint icon with frame corners
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Corner frames
                                    SizedBox(
                                      width: 65,
                                      height: 70,
                                      child: CustomPaint(
                                        painter: CornerFramePainter(),
                                      ),
                                    ),
                                    // Fingerprint icon
                                    const Icon(
                                      Icons.fingerprint,
                                      size: 45,
                                      color: AppTheme.primaryRed,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'USE BIOMETRIC',
                                  style: TextTheme.of(context).bodyLarge
                                      ?.copyWith(
                                        color: AppTheme.primaryRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for corner frames with rounded corners
class CornerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryRed
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 14.0;
    const radius = 8.0;

    // Top-left corner
    final topLeftPath = Path()
      ..moveTo(0, cornerLength)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius))
      ..lineTo(cornerLength, 0);
    canvas.drawPath(topLeftPath, paint);

    // Top-right corner
    final topRightPath = Path()
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(size.width, cornerLength);
    canvas.drawPath(topRightPath, paint);

    // Bottom-left corner
    final bottomLeftPath = Path()
      ..moveTo(0, size.height - cornerLength)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(
        Offset(radius, size.height),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(cornerLength, size.height);
    canvas.drawPath(bottomLeftPath, paint);

    // Bottom-right corner
    final bottomRightPath = Path()
      ..moveTo(size.width, size.height - cornerLength)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(
        Offset(size.width - radius, size.height),
        radius: const Radius.circular(radius),
      )
      ..lineTo(size.width - cornerLength, size.height);
    canvas.drawPath(bottomRightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

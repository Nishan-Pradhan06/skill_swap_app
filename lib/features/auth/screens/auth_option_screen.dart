import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/router/app_routes_names.dart';

import '../../../core/theme/app_theme.dart';

class AuthOptionScreen extends StatelessWidget {
  const AuthOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPadding(
        child: Column(
          spacing: 10,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset('assets/logo/logo1.png', height: 250),
            ),
            Text(
              'SKILL SWAP',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            // SizedBox(child: SvgPicture.asset('assets/logo/logo.svg')),
            Spacer(),
            CustomButton(
              leadingIcon: SvgPicture.asset(
                'assets/svg/icons/google.svg',
                height: 18,
              ),
              text: 'Continue with Google',
              onPressed: () {},
            ),
            CustomButton(
              text: 'Continue with Email',
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.backgroundLight
                  : Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.pushNamed(AppRoutesName.authSignInScreenRoute);
              },
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF272c29)
                  : Colors.white,
            ),
            CustomButton(
              text: 'Doesn\'t have an account?',
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.backgroundLight
                  : Theme.of(context).colorScheme.primary,
              onPressed: () {},
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF272c29)
                  : Colors.white,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Privacy Policy',
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Terms of Service',
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

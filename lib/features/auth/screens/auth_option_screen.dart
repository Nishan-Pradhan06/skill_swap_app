import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skill_swap/core/widgets/custom_background.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';

class AuthOptionScreen extends StatelessWidget {
  const AuthOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: CustomPadding(
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
                onPressed: () {},
                backgroundColor: Color(0XFF272c29),
              ),
              CustomButton(
                text: 'Doesn\'t have an account?',
                onPressed: () {},
                backgroundColor: Color(0XFF272c29),
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
      ),
    );
  }
}

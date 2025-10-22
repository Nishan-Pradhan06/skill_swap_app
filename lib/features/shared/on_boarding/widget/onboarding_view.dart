import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../../../../core/theme/app_theme.dart';
import '../model/on_boarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key, required this.data});

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(data.imageUrl, fit: BoxFit.contain),
          ),
        ),
        CustomPadding(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.headline,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: darkTextTheme
                      ? AppTheme.textSecondaryDark
                      : AppTheme.surfaceDark,
                ),
              ),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

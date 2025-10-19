import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../model/on_boarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key, required this.data});

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(data.imageUrl, fit: BoxFit.contain),
            ),
          ),
          Column(
            spacing: 20,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.headline,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

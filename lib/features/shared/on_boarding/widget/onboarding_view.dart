import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/on_boarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key, required this.data});

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(data.imageUrl, fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                data.headline,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(data.description, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

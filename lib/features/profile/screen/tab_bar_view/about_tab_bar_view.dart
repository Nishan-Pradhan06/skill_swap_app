import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_border.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_readmore_text.dart';

class AboutTabBarView extends StatelessWidget {
  const AboutTabBarView({super.key, required this.availableSkills});

  final List<String> availableSkills;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          CustomPadding(
            child: CustomReadMoreText(
              text:
                  'I\'m a Flutter developer and tech enthusiast passionate about creating fast, responsive, and elegant mobile apps. My journey began with hands-on practice and internships, and I continue learning new tools while sharing insights and engaging with the tech community on LinkedIn.',
            ),
          ),
          CustomBorder(),
          CustomPadding(
            vertical: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skill & Expertise',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: availableSkills.map((skill) {
                    return FilterChip(
                      padding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 0,
                      ),
                      label: Text(
                        skill,
                        style: TextTheme.of(context).bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      onSelected: (selected) {},
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.6),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.6),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          CustomBorder(),
        ],
      ),
    );
  }
}

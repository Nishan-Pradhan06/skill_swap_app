import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_border.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_readmore_text.dart';
import '../../widgets/certificate_container_widget.dart';

class AboutTabBarView extends StatelessWidget {
  const AboutTabBarView({super.key, required this.availableSkills});

  final List<String> availableSkills;

  @override
  Widget build(BuildContext context) {
    final certificates = [
      {
        'image':
            'https://media.licdn.com/dms/image/v2/D4D2DAQHh2VVYTFFrpQ/profile-treasury-document-images_480/B4DZVUylBxHIAU-/1/1740884301203?e=1762387200&v=beta&t=zDxREENZlTFnEafd0oYv_2lRhr85rn8KXxHyl7FR7zU',
        'title': 'Flutter Internship',
      },
      {
        'image':
            'https://media.licdn.com/dms/image/v2/D4D2DAQFq5DKnEDbshw/profile-treasury-image-shrink_800_800/profile-treasury-image-shrink_800_800/0/1706104536130?e=1762174800&v=beta&t=-dzEmS9Q_hH3ZNuWDBG-1YgZV__X6S5n2oDEW1X4-nM',
        'title': 'Flutter Certificate',
      },
      {
        'image':
            'https://media.licdn.com/dms/image/v2/D4D2DAQFSQeBY0mWPQQ/profile-treasury-image-shrink_800_800/profile-treasury-image-shrink_800_800/0/1706105868778?e=1762174800&v=beta&t=NlILFW8M3aYU7XAqTkyAlm9629kApMloJRxbncCpXik',
        'title': 'INC webathon',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
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
        CustomPadding(
          vertical: 5,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Certificate',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 12,
                  children: certificates.map((cert) {
                    return ContainerWithImageWidget(
                      certificateImageUrl: cert['image']!,
                      certificateTitle: cert['title']!,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        CustomBorder(),
        CustomPadding(
          vertical: 5,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Working Experience',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://media.licdn.com/dms/image/v2/D4D0BAQG_g0d95Eh5Sg/img-crop_100/img-crop_100/0/1721912200053?e=1762992000&v=beta&t=ymhfRIRDWP6xzpbzZeaAAepcXg8DZbr9ChpoawryhXA',
                    height: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Junior Flutter Mobile App Developer',
                        style: TextTheme.of(context).bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text('Lunar I.T. Solution Pvt. Ltd'),
                      Text(
                        'Itahari, Nepal',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '2 Years of Experience',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skill_swap/features/profile/model/certification_model.dart';
import 'package:skill_swap/features/profile/model/working_exprience_model.dart';

import '../../../../core/widgets/custom_border.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_readmore_text.dart';
import '../../widgets/certificate_container_widget.dart';
import '../../widgets/working_exp_widget.dart';

class AboutTabBarView extends StatelessWidget {
  final List<String> availableSkills;
  final List<WorkingExprienceModel> workExperiences;
  final List<CertificationModel> certifications;
  // final List<String> workingExprienceList;
  final String aboutBio;

  const AboutTabBarView({
    super.key,
    required this.availableSkills,
    required this.aboutBio,
    required this.certifications,
    required this.workExperiences,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        CustomPadding(child: CustomReadMoreText(text: aboutBio)),
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
              availableSkills.isEmpty
                  ? Text(
                      "No Skill added yet",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Wrap(
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
              certifications.isEmpty
                  ? Text(
                      "No certifications added yet",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12,
                        children: certifications.map((cert) {
                          return ContainerWithImageWidget(
                            certificateImageUrl: cert.image,
                            certificateTitle: cert.title,
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
              workExperiences.isEmpty
                  ? Text(
                      "No working experience added yet",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Column(
                      children: workExperiences.map((work) {
                        return Column(
                          children: [
                            WorkingExprienceList(
                              imageUrl: work.image,
                              title: work.title,
                              companyName: work.companyName,
                              location: work.location,
                              experience: work.experience,
                            ),
                            const Divider(),
                          ],
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

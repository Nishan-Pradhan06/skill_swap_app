import 'package:flutter/material.dart';
import 'package:skill_swap/features/profile/model/certification_model.dart';

import '../../../../core/widgets/custom_border.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_readmore_text.dart';
import '../../widgets/certificate_container_widget.dart';
import '../../widgets/working_exp_widget.dart';

class AboutTabBarView extends StatelessWidget {
  final List<String> availableSkills;
  final List<CertificationModel> certifications;
  // final List<String> workingExprienceList;
  final String aboutBio;

  const AboutTabBarView({
    super.key,
    required this.availableSkills,
    required this.aboutBio,
    required this.certifications,
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

              WorkingExprienceList(
                imageUrl:
                    'https://media.licdn.com/dms/image/v2/D4D0BAQG_g0d95Eh5Sg/img-crop_100/img-crop_100/0/1721912200053?e=1765411200&v=beta&t=LNZNNg0u2PGrgcyqTSkHDwHJnZZ9ijqA25tKl3bbwTg',
                title: 'Junior Flutter Mobile App Developer',
                companyName: 'Lunar I.T. Solution Pvt. Ltd',
                location: 'Itahari, Nepal',
                experience: '6 month of Experience',
              ),
              Divider(),
              WorkingExprienceList(
                imageUrl:
                    'https://media.licdn.com/dms/image/v2/D4D0BAQGDa4MdEnwpiw/company-logo_200_200/company-logo_200_200/0/1732850527682/sainotech010_logo?e=1765411200&v=beta&t=Pj9fl5KsBV9noKP9TqZJbOmJ2eorlkC09_IEmFNfSGc',
                title: 'Flutter Mobile App Developer',
                companyName: 'Saino Tech Pvt. Ltd',
                location: 'Itahari, Nepal',
                experience: '2 Years of Experience',
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_padding.dart';
import 'custom_cateogry_chip.dart';

class CustomSkillCard extends StatelessWidget {
  final String userName;
  final String userProfileUrl;
  final String categoryTitle;
  final String skillTitle;
  final String skillDescription;
  final List<Widget> skillList;
  final void Function()? onTap;
  const CustomSkillCard({
    super.key,
    required this.userName,
    required this.userProfileUrl,
    required this.categoryTitle,
    required this.skillTitle,
    required this.skillDescription,
    required this.skillList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      vertical: 0,
      child: CustomContainer(
        onTap: onTap,
        backgroundColor: Theme.of(context).colorScheme.surface,
        useIntrinsicHeight: true,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userProfileUrl),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text('Learner', style: TextTheme.of(context).bodySmall),
                      ],
                    ),
                  ],
                ),
                CustomCategoryChip(chipText: categoryTitle),
              ],
            ),
            Text(
              skillTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(
                context,
              ).bodyLarge?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              skillDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: TextTheme.of(context).bodySmall,
            ),
            Text(
              'Looking for:',
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Wrap(spacing: 6, runSpacing: 6, children: skillList),
          ],
        ),
      ),
    );
  }
}

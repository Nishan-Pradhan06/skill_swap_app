import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_padding.dart';
import 'custom_cateogry_chip.dart';
import '../../../../core/utils/image_url_utils.dart';

class CustomSkillCard extends StatelessWidget {
  final String userName;
  final String userProfileUrl;
  final String categoryTitle;
  final String skillTitle;
  final String skillDescription;
  final void Function()? onTap;
  final String point;
  final List<String>? skills;
  const CustomSkillCard({
    super.key,
    required this.userName,
    required this.userProfileUrl,
    required this.categoryTitle,
    required this.skillTitle,
    required this.skillDescription,
    required this.point,
    this.availabilityText,
    this.slotInfo,
    this.skills,
    this.onTap,
    this.trailing,
  });

  final String? availabilityText;
  final String? slotInfo;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      child: ClipOval(
                        child: userProfileUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: ImageUrlUtils.getImageUrl(
                                  userProfileUrl,
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/images/default_profile.png',
                                      fit: BoxFit.cover,
                                    ),
                              )
                            : Image.asset(
                                'assets/images/default_profile.png',
                                fit: BoxFit.cover,
                              ),
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
                        // Text('Learner', style: TextTheme.of(context).bodySmall),
                        Row(
                          spacing: 2,
                          children: [
                            Text(
                              point,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: TextTheme.of(context).bodySmall,
                            ),
                            Image.asset('assets/images/coin.png', height: 10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 4,
                  children: [
                    CustomCategoryChip(chipText: categoryTitle),
                    if (trailing != null) trailing!,
                  ],
                ),
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
            if (availabilityText != null || slotInfo != null) ...[
              const SizedBox(height: 4),
              Column(
                children: [
                  if (availabilityText != null) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          availabilityText!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (availabilityText != null && slotInfo != null)
                    const SizedBox(width: 12),
                  if (slotInfo != null) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.event_seat,
                          size: 14,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          slotInfo!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
            Text(
              'Skill you will learn:',
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (skills != null && skills!.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: skills!
                    .map((s) => CustomCategoryChip(chipText: s))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

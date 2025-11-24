import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_padding.dart';

class CustomUserProfileHeader extends StatelessWidget {
  final String profileImageUrl;
  final String coverImageUrl;
  final String userName;
  final String userTitle;

  const CustomUserProfileHeader({
    super.key,
    required this.profileImageUrl,
    required this.coverImageUrl,
    required this.userName,
    required this.userTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomContainer(
          padding: EdgeInsetsGeometry.all(0),
          clipRRectBorderRadius: BorderRadius.circular(0),
          useIntrinsicHeight: true,
          borderRadius: BorderRadius.circular(0),
          child: CachedNetworkImage(
            useOldImageOnUrlChange: true,
            errorWidget: (context, url, error) {
              return Image.asset('assets/images/banner.png');
            },
            imageUrl: coverImageUrl,
          ),
        ),
        CustomPadding(
          horizontal: 12,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              constraints: BoxConstraints(),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.mode_edit_rounded, size: 14),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Picture
              CircleAvatar(
                radius: 55,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerLowest,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: profileImageUrl,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          'assets/images/default_profile.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

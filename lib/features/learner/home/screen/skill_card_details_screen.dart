import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../../../../core/utils/image_url_utils.dart';
import 'package:skill_swap/features/learner/home/widgets/custom_cateogry_chip.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/pages/learner_booking_page.dart';

class SkillCardDetailsScreen extends StatelessWidget {
  final SkillSwapPostModel post;
  const SkillCardDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkTextTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner / Image placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            CustomPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCategoryChip(
                        chipText: post.category?.name ?? "General",
                      ),
                      Row(
                        children: [
                          Text(
                            post.pointsCost.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Image.asset('assets/images/coin.png', height: 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    post.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Mentor Info
                  Row(
                    children: [
                      ClipOval(
                        child: (post.user.profileImage?.isNotEmpty ?? false)
                            ? CachedNetworkImage(
                                imageUrl: ImageUrlUtils.getImageUrl(
                                  post.user.profileImage!,
                                ),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/default_profile.png',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.user.fullName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            post.user.mainCategory ?? "Mentor",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: darkTextTheme ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Skill to Learn",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [CustomCategoryChip(chipText: post.skillToLearn)],
                  ),
                  const SizedBox(height: 24),

                  if (post.teachDate != null ||
                      (post.availableSlotsCount ?? 0) > 0) ...[
                    Text(
                      "Teach Details",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          post.availabilityRange,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.event_available,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${post.availableSlotsCount ?? 0} slots available / ${post.totalSlotsCount ?? 0} total",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (post.learnDate != null) ...[
                    Text(
                      "Learn Details",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.school, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "${post.learnDate ?? "Not specified"} ${post.learnTime ?? ""}",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                  BlocBuilder<GetProfileBloc, GetProfileState>(
                    builder: (context, state) {
                      final currentUserId = state.maybeWhen(
                        loaded: (data) => data.id,
                        orElse: () => null,
                      );
                      final isOwnPost = currentUserId == post.user.id;

                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isOwnPost
                              ? () {
                                  // Optionally navigate to edit
                                }
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LearnerBookingPage(
                                        mentorId: post.user.id,
                                        postId: post.id,
                                        skillTitle: post.skillToLearn,
                                        pointsCost: post.pointsCost,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isOwnPost
                                ? Colors.grey[300]
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isOwnPost ? "My Post" : "Book a Session",
                            style: TextStyle(
                              color: isOwnPost ? Colors.black54 : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

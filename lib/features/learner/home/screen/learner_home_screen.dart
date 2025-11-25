import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/features/notifications/bloc/get_notification_count/get_notification_count_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/skill_list_card_model.dart';
import '../widgets/custom_cateogry_chip.dart';
import '../widgets/custom_filter_chip.dart';
import '../widgets/custom_profile_header.dart';
import '../widgets/custom_skill_card.dart';

class LearnerHomeScreen extends StatefulWidget {
  const LearnerHomeScreen({super.key});

  @override
  State<LearnerHomeScreen> createState() => _LearnerHomeScreenState();
}

class _LearnerHomeScreenState extends State<LearnerHomeScreen> {
  bool isLoading = false;

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call or actual data fetching
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  final List<String> filterCategory = [
    'All',
    'Programming',
    'Design',
    'Writing',
    'Marketing',
    'Photography',
    'Video Editing',
    'Music',
    'Teaching',
    'Cooking',
    'Gardening',
  ];

  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    sl<GetProfileBloc>().add(GetProfileEvent.getProfile());
    sl<GetNotificationBloc>().add(GetNotificationEvent.getNotification());
    sl<GetNotificationCountBloc>().add(
      GetNotificationCountEvent.getNotificationCount(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    final filteredSkills = selectedCategory == 'All'
        ? skillCards
        : skillCards
              .where(
                (card) => card.categoryTitle.toLowerCase().contains(
                  selectedCategory.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 180,
                elevation: 0,
                floating: true,
                snap: true,
                pinned: false,
                scrolledUnderElevation: 0,
                forceElevated: false,

                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomPadding(
                              horizontal: 0,
                              child: CustomProfileHeader(isLoading: isLoading),
                            ),
                            CustomPadding(
                              vertical: 0,
                              child: CustomTextField(
                                hint: 'Search',
                                borderColor: Colors.transparent,
                                borderRadius: 18,
                                type: CustomTextFieldType.search,
                                fillColor: darkTextTheme
                                    ? const Color(0XFF272c29)
                                    : AppTheme.surfaceLight,
                              ),
                            ),
                            SizedBox(height: 10),
                            CategoryFilterChips(
                              categories: filterCategory,
                              selectedCategory: selectedCategory,
                              onCategorySelected: (category) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final skill = filteredSkills[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: CustomSkillCard(
                        userName: skill.userName,
                        userProfileUrl: skill.userProfileUrl,
                        categoryTitle: skill.categoryTitle,
                        skillTitle: skill.skillTitle,
                        skillDescription: skill.skillDescription,
                        skillList: skill.skillList
                            .map((text) => CustomCategoryChip(chipText: text))
                            .toList(),
                        point: skill.point,
                        onTap: () {
                          context.pushNamed(AppRoutesName.skillCardDetails);
                        },
                      ),
                    ),
                  );
                }, childCount: filteredSkills.length),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 35,
        width: 45,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Icon(Icons.message_rounded),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          backgroundColor: ColorScheme.of(context).onInverseSurface,
        ),
      ),
    );
  }
}

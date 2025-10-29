import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';
import '../../models/skill_list_card_model.dart';
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
        child: ScrollableRefreshablePadding(
          onRefresh: _handleRefresh,
          child: CustomPadding(
            horizontal: 0,
            child: Column(
              spacing: 10,
              children: [
                CustomProfileHeader(isLoading: isLoading),
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
                CategoryFilterChips(
                  categories: filterCategory,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),

                ListView.builder(
                  itemCount: filteredSkills.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
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
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

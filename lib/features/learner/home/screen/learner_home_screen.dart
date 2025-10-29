import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';
import '../widgets/custom_profile_header.dart';

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

  List<String> category = [];
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ScrollableRefreshablePadding(
          onRefresh: _handleRefresh,
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
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    spacing: 10,
                    children: filterCategory.map((category) {
                      final isSelected = category.contains(category);
                      return FilterChip(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                        label: Text(
                          category,
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                            color: isSelected
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.background,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        chipAnimationStyle: ChipAnimationStyle(
                          selectAnimation: AnimationStyle(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   height: 140,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(18),
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              // ),
              // Container(
              //   width: double.infinity,
              //   height: 10,
              //   color: Theme.of(context).colorScheme.surface,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

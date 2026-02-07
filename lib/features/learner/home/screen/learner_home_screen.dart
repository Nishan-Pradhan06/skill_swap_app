import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:skill_swap/features/notifications/bloc/get_notification_count/get_notification_count_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_skill_swap_posts_bloc.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../widgets/custom_filter_chip.dart';
import '../widgets/custom_profile_header.dart';
import '../widgets/custom_skill_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_categories_bloc.dart';
import '../../../../core/theme/app_theme.dart';

class LearnerHomeScreen extends StatefulWidget {
  const LearnerHomeScreen({super.key});

  @override
  State<LearnerHomeScreen> createState() => _LearnerHomeScreenState();
}

class _LearnerHomeScreenState extends State<LearnerHomeScreen> {
  bool isLoading = false;

  Future<void> _handleRefresh() async {
    context.read<GetProfileBloc>().add(GetProfileEvent.getProfile());
    context.read<GetNotificationBloc>().add(
      GetNotificationEvent.getNotification(),
    );
    context.read<GetNotificationCountBloc>().add(
      GetNotificationCountEvent.getNotificationCount(),
    );
    context.read<GetSkillSwapPostsBloc>().add(
      const GetSkillSwapPostsEvent.getPosts(),
    );
    CustomToast.showSuccess("Refreshed");
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
    context.read<GetCategoriesBloc>().add(
      const GetCategoriesEvent.getCategories(),
    );
  }

  String selectedCategory = 'All';
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

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
                              child: CustomProfileHeader(
                                isLoading: isLoading,
                                currentRole: 'LEARNER',
                              ),
                            ),
                            BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                              builder: (context, state) {
                                final hintText = state.maybeWhen(
                                  loaded: (cats) =>
                                      "Looking for ${cats.take(3).map((e) => e.name).join(', ')}...",
                                  orElse: () => "Search for skills...",
                                );
                                return CustomPadding(
                                  vertical: 0,
                                  child: CustomTextField(
                                    hint: hintText,
                                    borderColor: Colors.transparent,
                                    borderRadius: 18,
                                    type: CustomTextFieldType.search,
                                    fillColor: darkTextTheme
                                        ? const Color(0XFF272c29)
                                        : AppTheme.surfaceLight,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  loaded: (categories) {
                                    final List<String> catNames = [
                                      'All',
                                      ...categories.map((e) => e.name),
                                    ];
                                    return CategoryFilterChips(
                                      categories: catNames,
                                      selectedCategory: selectedCategory,
                                      onCategorySelected: (category) {
                                        setState(() {
                                          selectedCategory = category;
                                          if (category == 'All') {
                                            selectedCategoryId = null;
                                          } else {
                                            selectedCategoryId = categories
                                                .firstWhere(
                                                  (e) => e.name == category,
                                                )
                                                .id;
                                          }
                                        });
                                      },
                                    );
                                  },
                                  loading: () => const Center(
                                    child: LinearProgressIndicator(),
                                  ),
                                  orElse: () =>
                                      const Text("Failed to load categories"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              BlocBuilder<GetSkillSwapPostsBloc, GetSkillSwapPostsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Skeletonizer(
                          enabled: true,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: const CustomSkillCard(
                              userName: "Skeleton User",
                              userProfileUrl: "",
                              categoryTitle: "Category",
                              skillTitle: "Skill Title",
                              skillDescription:
                                  "This is a long description for skeleton loading",
                              point: "0",
                            ),
                          ),
                        ),
                        childCount: 5,
                      ),
                    ),
                    loaded: (posts) {
                      final filteredSkills = selectedCategoryId == null
                          ? posts
                          : posts
                                .where(
                                  (post) =>
                                      post.category?.id == selectedCategoryId,
                                )
                                .toList();

                      if (filteredSkills.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(child: Text("No posts found")),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final skill = filteredSkills[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: CustomSkillCard(
                              userName: skill.user.fullName,
                              userProfileUrl: skill.user.profileImage ?? '',
                              categoryTitle: skill.category?.name ?? 'General',
                              skillTitle: skill.title,
                              skillDescription: skill.description,
                              point: skill.pointsCost.toString(),
                              skills: skill.skillToLearn
                                  .split(',')
                                  .map((s) => s.trim())
                                  .where((s) => s.isNotEmpty)
                                  .toList(),

                              slotInfo: skill.totalSlotsCount != null
                                  ? "${skill.availableSlotsCount ?? 0}/${skill.totalSlotsCount} slots"
                                  : null,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutesName.skillCardDetails,
                                  extra: skill,
                                );
                              },
                            ),
                          );
                        }, childCount: filteredSkills.length),
                      );
                    },
                    failure: (message) => SliverToBoxAdapter(
                      child: Center(child: Text("Error: $message")),
                    ),
                    orElse: () =>
                        const SliverToBoxAdapter(child: SizedBox.shrink()),
                  );
                },
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
          label: Icon(
            Icons.message_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
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

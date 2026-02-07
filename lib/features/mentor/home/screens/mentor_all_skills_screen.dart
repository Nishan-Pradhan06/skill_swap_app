import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_mentor_posts_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../learner/home/widgets/custom_skill_card.dart';
import '../../../learner/home/widgets/custom_filter_chip.dart';

class MentorAllSkillsScreen extends StatefulWidget {
  const MentorAllSkillsScreen({super.key});

  @override
  State<MentorAllSkillsScreen> createState() => _MentorAllSkillsScreenState();
}

class _MentorAllSkillsScreenState extends State<MentorAllSkillsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    context.read<GetMentorPostsBloc>().add(
      const GetMentorPostsEvent.getPosts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All My Skills"),
        scrolledUnderElevation: 0,

        // actions: [
        //   IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        // ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          CategoryFilterChips(
            categories: _filters,
            selectedCategory: _selectedFilter,
            onCategorySelected: (filter) {
              setState(() => _selectedFilter = filter);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<GetMentorPostsBloc, GetMentorPostsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (posts) {
                    final filteredPosts = posts.where((post) {
                      if (_selectedFilter == 'All') return true;
                      if (_selectedFilter == 'Active') return post.isActive;
                      if (_selectedFilter == 'Inactive') return !post.isActive;
                      return true;
                    }).toList();

                    if (filteredPosts.isEmpty) {
                      return Center(
                        child: Text(
                          _selectedFilter == 'All'
                              ? "No skills created yet."
                              : "No $_selectedFilter skills found.",
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        return CustomPadding(
                          horizontal: 0,
                          vertical: 4,
                          child: CustomSkillCard(
                            userName: post.user.fullName,
                            userProfileUrl: post.user.profileImage ?? '',
                            categoryTitle: post.category?.name ?? 'General',
                            skillTitle: post.title,
                            skillDescription: post.description,
                            point: post.pointsCost.toString(),
                            skills: post.skillToLearn
                                .split(',')
                                .map((s) => s.trim())
                                .where((s) => s.isNotEmpty)
                                .toList(),
                            slotInfo: post.totalSlotsCount != null
                                ? "${post.availableSlotsCount ?? 0}/${post.totalSlotsCount} slots"
                                : null,
                            onTap: () async {
                              final result = await context.pushNamed(
                                AppRoutesName.skillPostFormRoute,
                                extra: post,
                              );
                              if (!mounted) return;
                              if (result == true) _refresh();
                            },
                          ),
                        );
                      },
                    );
                  },
                  failure: (msg) => Center(child: Text(msg)),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(
            AppRoutesName.skillPostFormRoute,
          );
          if (!mounted) return;
          if (result == true) _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

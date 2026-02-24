import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_mentor_posts_bloc.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/manage_skill_post_bloc.dart';
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

  void _showDeleteDialog(int postId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Skill"),
        content: const Text("Are you sure you want to delete this skill post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ManageSkillPostBloc>().add(
                ManageSkillPostEvent.delete(postId),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageSkillPostBloc, ManageSkillPostState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            CustomToast.showSuccess(message);
            _refresh();
          },
          failure: (message) => CustomToast.showError(message),
        );
      },
      child: Scaffold(
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
                        if (_selectedFilter == 'Inactive') {
                          return !post.isActive;
                        }
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
                              trailing: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showDeleteDialog(post.id),
                              ),
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
          heroTag: 'mentor_all_skills_fab',
          onPressed: () async {
            final result = await context.pushNamed(
              AppRoutesName.skillPostFormRoute,
            );
            if (!mounted) return;
            if (result == true) _refresh();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

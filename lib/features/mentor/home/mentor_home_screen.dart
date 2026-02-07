import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_mentor_posts_bloc.dart';
import '../../learner/home/widgets/custom_skill_card.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../learner/home/widgets/custom_profile_header.dart';

class MentorHomeScreen extends StatefulWidget {
  const MentorHomeScreen({super.key});

  @override
  State<MentorHomeScreen> createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends State<MentorHomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    context.read<GetMentorPostsBloc>().add(
      const GetMentorPostsEvent.getPosts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,

          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomPadding(
                  horizontal: 0,
                  child: CustomProfileHeader(
                    isLoading: isLoading,
                    currentRole: 'MENTOR',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: CustomPadding(
                  child: Text(
                    "My Active Skills",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              BlocBuilder<GetMentorPostsBloc, GetMentorPostsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    loaded: (posts) {
                      if (posts.isEmpty) {
                        return SliverToBoxAdapter(
                          child: CustomPadding(
                            child: InkWell(
                              onTap: () => context.pushNamed(
                                AppRoutesName.skillPostFormRoute,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 48,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text("Create your first skill post"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final post = posts[index];
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
                                if (result == true) _handleRefresh();
                              },
                            ),
                          );
                        }, childCount: posts.length),
                      );
                    },
                    failure: (msg) =>
                        SliverToBoxAdapter(child: Center(child: Text(msg))),
                    orElse: () =>
                        const SliverToBoxAdapter(child: SizedBox.shrink()),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await context.pushNamed(
            AppRoutesName.skillPostFormRoute,
          );
          if (result == true) _handleRefresh();
        },
        icon: const Icon(Icons.add),
        label: const Text("Create Skill"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

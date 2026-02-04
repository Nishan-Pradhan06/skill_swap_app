import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_mentor_posts_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/manage_skill_post_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';

class MentorPostsScreen extends StatefulWidget {
  const MentorPostsScreen({super.key});

  @override
  State<MentorPostsScreen> createState() => _MentorPostsScreenState();
}

class _MentorPostsScreenState extends State<MentorPostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMentorPostsBloc>().add(
      const GetMentorPostsEvent.getPosts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageSkillPostBloc, ManageSkillPostState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            CustomToast.showSuccess(message);
            context.read<GetMentorPostsBloc>().add(
              const GetMentorPostsEvent.getPosts(),
            );
          },
          failure: (message) => CustomToast.showError(message),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("My Skill Posts")),
        body: BlocBuilder<GetMentorPostsBloc, GetMentorPostsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (posts) {
                if (posts.isEmpty) {
                  return const Center(
                    child: Text("You haven't created any skills yet."),
                  );
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${post.skillToLearn} • ${post.pointsCost} pts",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final result = await context.pushNamed(
                                  AppRoutesName.skillPostFormRoute,
                                  extra: post,
                                );
                                if (result == true) {
                                  context.read<GetMentorPostsBloc>().add(
                                    const GetMentorPostsEvent.getPosts(),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Delete Skill"),
                                    content: const Text(
                                      "Are you sure you want to delete this skill post?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          context
                                              .read<ManageSkillPostBloc>()
                                              .add(
                                                ManageSkillPostEvent.delete(
                                                  post.id,
                                                ),
                                              );
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              failure: (message) => Center(child: Text("Error: $message")),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final result = await context.pushNamed(
              AppRoutesName.skillPostFormRoute,
            );
            if (result == true) {
              context.read<GetMentorPostsBloc>().add(
                const GetMentorPostsEvent.getPosts(),
              );
            }
          },
          icon: const Icon(Icons.add),
          label: const Text("Create New Skill"),
        ),
      ),
    );
  }
}

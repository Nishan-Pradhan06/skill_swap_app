import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import 'package:skill_swap/core/helpers/url_launcher_helper.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';

class MeetingLinksListScreen extends StatelessWidget {
  const MeetingLinksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Links'),
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<GetSessionsBloc, GetSessionsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load meeting links',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            success: (data) {
              final sessions = data
                  .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
                  .where(
                    (session) =>
                        session.status == 'CONFIRMED' &&
                        session.meetingLink != null &&
                        session.meetingLink!.isNotEmpty,
                  )
                  .toList();

              if (sessions.isEmpty) {
                return _buildEmptyState(context);
              }

              // Group sessions by skill
              final Map<String, List<SessionModel>> sessionsBySkill = {};
              for (var session in sessions) {
                if (!sessionsBySkill.containsKey(session.skill)) {
                  sessionsBySkill[session.skill] = [];
                }
                sessionsBySkill[session.skill]!.add(session);
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sessionsBySkill.length,
                itemBuilder: (context, index) {
                  final skill = sessionsBySkill.keys.elementAt(index);
                  final skillSessions = sessionsBySkill[skill]!;
                  final meetingLink = skillSessions.first.meetingLink!;

                  return _buildMeetingLinkCard(
                    context,
                    skill,
                    meetingLink,
                    skillSessions.length,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMeetingLinkCard(
    BuildContext context,
    String skill,
    String meetingLink,
    int sessionCount,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.school,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$sessionCount session${sessionCount > 1 ? 's' : ''}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Icon(Icons.link, size: 20, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final uri = Uri.parse(meetingLink);
                      urlLauncherWithFallback(context, uri);
                    },
                    child: Text(
                      meetingLink,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: meetingLink));
                      CustomToast.showSuccess(
                        'Meeting link copied to clipboard',
                      );
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Copy Link'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final uri = Uri.parse(meetingLink);
                      urlLauncherWithFallback(context, uri);
                    },
                    icon: const Icon(Icons.video_call, size: 18),
                    label: const Text('Join Meeting'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.link_off, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Meeting Links',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create meeting links for your skills\nto see them here',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

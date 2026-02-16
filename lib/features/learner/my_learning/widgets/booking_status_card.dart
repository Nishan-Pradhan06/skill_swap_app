import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import 'package:skill_swap/core/helpers/url_launcher_helper.dart';

class BookingStatusCard extends StatelessWidget {
  final SessionModel session;

  const BookingStatusCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mentor = session.mentor;
    final scheduledTime = session.scheduledTime.toLocal();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: mentor['profile_image'] != null
                    ? CachedNetworkImageProvider(mentor['profile_image'])
                    : null,
                child: mentor['profile_image'] == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor['full_name'] ?? 'Unknown Mentor',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Learning ${session.skill}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusIndicator(session.status),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                context,
                Icons.calendar_today_outlined,
                DateFormat('MMM dd').format(scheduledTime),
              ),
              _buildInfoItem(
                context,
                Icons.access_time,
                DateFormat('hh:mm a').format(scheduledTime),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${session.points} pts",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          // Debug logging
          Builder(
            builder: (context) {
              print('=== Session Debug Info ===');
              print('Session ID: ${session.id}');
              print('Status: ${session.status}');
              print('Meeting Link: ${session.meetingLink}');
              print('Meeting Link isEmpty: ${session.meetingLink?.isEmpty}');
              print(
                'Condition check: ${session.status == 'CONFIRMED' && session.meetingLink != null && session.meetingLink!.isNotEmpty}',
              );
              print('========================');
              return const SizedBox.shrink();
            },
          ),
          if (session.status == 'CONFIRMED' &&
              session.meetingLink != null &&
              session.meetingLink!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Meeting Link',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: session.meetingLink!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy, size: 16),
                          tooltip: 'Copy link',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        final uri = Uri.parse(session.meetingLink!);
                        urlLauncherWithFallback(context, uri);
                      },
                      child: Text(
                        session.meetingLink!,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final now = DateTime.now();
                        final startTime = session.scheduledTime.subtract(
                          const Duration(minutes: 15),
                        );
                        final endTime = session.scheduledTime.add(
                          Duration(minutes: session.durationMinutes),
                        );

                        final isLive =
                            now.isAfter(startTime) && now.isBefore(endTime);

                        if (!isLive) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Join button will be available 15 minutes before session',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final uri = Uri.parse(session.meetingLink!);
                              urlLauncherWithFallback(context, uri);
                            },
                            icon: const Icon(Icons.video_call, size: 18),
                            label: const Text("Join Session"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 36),
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color color;
    IconData icon;
    String label = status;

    switch (status) {
      case 'CONFIRMED':
      case 'ACCEPTED':
        color = Colors.green;
        icon = Icons.check_circle_outline;
        label = 'CONFIRMED';
        break;
      case 'CANCELLED':
      case 'REJECTED':
        color = Colors.red;
        icon = Icons.highlight_off;
        label = status == 'REJECTED' ? 'REJECTED' : 'CANCELLED';
        break;
      case 'COMPLETED':
        color = Colors.blue;
        icon = Icons.task_alt;
        break;
      default:
        color = Colors.orange;
        icon = Icons.hourglass_empty;
        label = "PENDING";
    }

    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

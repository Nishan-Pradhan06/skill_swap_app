import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';

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
          if (session.status == 'ACCEPTED' && session.meetingLink != null) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Handle link
              },
              icon: const Icon(Icons.video_call),
              label: const Text("Join Session"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
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
      case 'ACCEPTED':
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case 'REJECTED':
        color = Colors.red;
        icon = Icons.highlight_off;
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

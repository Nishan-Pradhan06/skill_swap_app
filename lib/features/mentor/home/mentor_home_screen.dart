import 'package:flutter/material.dart';

import '../../../core/widgets/custom_padding.dart';
import '../../learner/home/widgets/custom_profile_header.dart';

class MentorHomeScreen extends StatefulWidget {
  const MentorHomeScreen({super.key});

  @override
  State<MentorHomeScreen> createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends State<MentorHomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPadding(
                  horizontal: 0,
                  child: CustomProfileHeader(isLoading: isLoading),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.emoji_events_outlined,
                          title: 'Points Earned',
                          value: '12,450',
                          subtitle: '+850 this week',
                          color: colorScheme.secondary,
                          theme: theme,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.people_outline,
                          title: 'Active Learners',
                          value: '24',
                          subtitle: '3 new this month',
                          color: colorScheme.tertiary,
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Upcoming Sessions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Sessions',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Session Cards
                _SessionCard(
                  studentName: 'Sarah Johnson',
                  subject: 'Mathematics - Calculus',
                  time: 'Today, 2:00 PM',
                  duration: '1 hour',
                  avatarColor: colorScheme.primary,
                  theme: theme,
                ),
                _SessionCard(
                  studentName: 'Mike Chen',
                  subject: 'Physics - Mechanics',
                  time: 'Today, 4:30 PM',
                  duration: '45 mins',
                  avatarColor: colorScheme.tertiary,
                  theme: theme,
                ),
                _SessionCard(
                  studentName: 'Emma Wilson',
                  subject: 'Chemistry - Organic',
                  time: 'Tomorrow, 10:00 AM',
                  duration: '1 hour',
                  avatarColor: colorScheme.secondary,
                  theme: theme,
                ),

                const SizedBox(height: 24),

                // Quick Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Quick Actions',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.calendar_today_outlined,
                          label: 'Schedule',
                          color: colorScheme.primary,
                          theme: theme,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.assessment_outlined,
                          label: 'Analytics',
                          color: colorScheme.tertiary,
                          theme: theme,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.message_outlined,
                          label: 'Messages',
                          color: colorScheme.secondary,
                          theme: theme,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final ThemeData theme;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final String studentName;
  final String subject;
  final String time;
  final String duration;
  final Color avatarColor;
  final ThemeData theme;

  const _SessionCard({
    required this.studentName,
    required this.subject,
    required this.time,
    required this.duration,
    required this.avatarColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: avatarColor.withValues(alpha: 0.1),
          child: Text(
            studentName[0],
            style: theme.textTheme.titleLarge?.copyWith(
              color: avatarColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(studentName, style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subject, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(time, style: theme.textTheme.bodySmall),
                const SizedBox(width: 16),
                Icon(
                  Icons.timelapse,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(duration, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.videocam_outlined),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final ThemeData theme;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

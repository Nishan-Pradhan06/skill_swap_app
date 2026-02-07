import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_container.dart';

class MentorStatsCard extends StatelessWidget {
  final int totalStudents;
  final int dailyPoints;

  const MentorStatsCard({
    super.key,
    required this.totalStudents,
    required this.dailyPoints,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      backgroundColor: ColorScheme.of(context).surface,
      useIntrinsicHeight: true,
      child: Row(
        children: [
          _buildStatItem(
            context,
            icon: Icons.people_outline,
            label: 'Total Students',
            value: totalStudents.toString(),
            iconColor: Colors.blue,
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.grey.withValues(alpha: 0.2),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _buildStatItem(
            context,
            icon: Icons.stars_outlined,
            label: 'Daily Point Earn',
            value: dailyPoints.toString(),
            iconColor: Colors.orange,
            isPoints: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isPoints = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              if (isPoints) ...[
                const SizedBox(width: 4),
                Image.asset('assets/images/coin.png', height: 20),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

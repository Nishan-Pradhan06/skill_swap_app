import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import '../../my_learning/widgets/booking_status_card.dart';

class PendingSwaps extends StatelessWidget {
  final List<SessionModel> sessions;
  final String emptyMessage;

  const PendingSwaps({
    super.key,
    required this.sessions,
    this.emptyMessage = 'No pending swaps',
  });

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return Center(
        child: Text(emptyMessage, style: const TextStyle(color: Colors.grey)),
      );
    }

    return CustomPadding(
      vertical: 0,
      child: ScrollableRefreshablePadding(
        onRefresh: () async {
          // You could trigger a refresh here if needed
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            ...sessions.map((session) => BookingStatusCard(session: session)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

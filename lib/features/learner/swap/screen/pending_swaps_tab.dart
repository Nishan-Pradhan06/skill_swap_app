import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';
import '../widgets/swap_card_widget.dart';

class PendingSwaps extends StatelessWidget {
  const PendingSwaps({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      child: ScrollableRefreshablePadding(
        onRefresh: () async {},
        child: Column(
          spacing: 10,
          children: [
            SwapCardWidget(),
            SwapCardWidget(),
            SwapCardWidget(),
            SwapCardWidget(),

            SwapCardWidget(),
          ],
        ),
      ),
    );
  }
}

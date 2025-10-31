import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';

class SkillCardDetailsScreen extends StatelessWidget {
  const SkillCardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollableRefreshablePadding(
          onRefresh: () async {},
          child: CustomPadding(child: Column(children: [CustomBackButton(),
          
          
          
          ])),
        ),
      ),
    );
  }
}

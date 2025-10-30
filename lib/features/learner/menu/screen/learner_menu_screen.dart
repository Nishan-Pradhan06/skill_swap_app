import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';

import '../../../../core/widgets/custom_appearance_mode_selector.dart';
import '../../../../core/widgets/custom_setting_widget.dart';

class LearnerMenuScreen extends StatelessWidget {
  const LearnerMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        scrolledUnderElevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: ScrollableRefreshablePadding(
        onRefresh: () async {},
        child: CustomPadding(
          child: Column(
            children: [
              SettingTile(
                icon: Icons.person_2_rounded,
                title: 'Personal Details',
                onTap: () {},
              ),
              SettingTile(
                icon: Icons.security_rounded,
                title: 'Security & Privacy',
                onTap: () {},
              ),
              SettingTile(
                icon: Icons.help_outline_rounded,
                title: 'Support',
                onTap: () {},
              ),
              SettingTile(
                icon: Icons.balance_rounded,
                title: 'Legal',
                onTap: () {},
              ),
              SettingTile(
                icon: Icons.info_rounded,
                title: 'About Us',
                onTap: () {},
              ),
              SettingTile(
                icon: Icons.color_lens_rounded,
                title: 'App Appearance',
                showTrailing: false,
              ),
              const SizedBox(height: 8),
              AppearanceModeSelector(),
              const SizedBox(height: 80),
              Text(
                'SkillSwap v1.0.0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

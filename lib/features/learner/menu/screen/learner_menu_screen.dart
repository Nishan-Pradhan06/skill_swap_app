import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/auth/bloc/bloc/sign_out_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';

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
          BlocConsumer<SignOutBloc, SignOutState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (failure) {
                  CustomToast.showError(failure.message);
                },
                loaded: (data) {
                  context.goNamed(AppRoutesName.authOptionScreenRoute);
                  CustomToast.showSuccess("Sign Out Successufully");
                },
              );
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  sl<SignOutBloc>().add(SignOutEvent.signOut());
                },
                icon: const Icon(Icons.exit_to_app_rounded),
              );
            },
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
                onTap: () {
                  context.pushNamed(AppRoutesName.perosalDetailScreenRoute);
                },
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

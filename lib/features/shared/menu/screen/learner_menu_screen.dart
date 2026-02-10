import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/auth/bloc/bloc/sign_out_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/switch_role/switch_role_bloc.dart';
import 'package:skill_swap/features/profile/model/roles_model.dart';
import 'package:skill_swap/router/app_routes_names.dart';

import '../../../../core/services/cache_service.dart';
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
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.exit_to_app_rounded),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              const SizedBox(height: 30),
              BlocBuilder<GetProfileBloc, GetProfileState>(
                builder: (context, state) {
                  return state.when(
                    failure: (failure) => SizedBox(),
                    initial: () => SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (roles) {
                      return FutureBuilder<String?>(
                        future: CacheServices.instance.getUserRole(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          }
                          final currentRole = snapshot.data ?? 'LEARNER';

                          return BlocConsumer<SwitchRoleBloc, SwitchRoleState>(
                            listener: (context, switchState) {
                              switchState.whenOrNull(
                                loaded: (message) async {
                                  // Update cached role for SplashScreen or global use
                                  await CacheServices.instance.setUserRole(
                                    currentRole == 'LEARNER'
                                        ? 'MENTOR'
                                        : 'LEARNER',
                                  );

                                  // Refresh profile after role switch
                                  sl<GetProfileBloc>().add(
                                    GetProfileEvent.getProfile(),
                                  );

                                  // Show success toast
                                  CustomToast.showSuccess(
                                    "Role switched successfully",
                                  );

                                  // Navigate based on the new role
                                  final newRole = currentRole == 'LEARNER'
                                      ? 'MENTOR'
                                      : 'LEARNER';
                                  if (newRole == 'LEARNER') {
                                    context.goNamed(
                                      AppRoutesName.learnerBottomNavBar,
                                    );
                                  } else if (newRole == 'MENTOR') {
                                    context.goNamed(
                                      AppRoutesName.mentorBottomNavBar,
                                    );
                                  }
                                },
                                failure: (failure) {
                                  CustomToast.showError(failure.message);
                                },
                              );
                            },
                            builder: (context, switchState) {
                              final isLoading = switchState.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              );

                              final isLearner = currentRole == 'LEARNER';

                              return CustomButton(
                                isDisabled: isLoading,
                                isLoading: isLoading,
                                text: isLearner
                                    ? "Switch To Mentor"
                                    : "Switch To Learner",
                                onPressed: () {
                                  final newRole = isLearner
                                      ? 'MENTOR'
                                      : 'LEARNER';

                                  sl<SwitchRoleBloc>().add(
                                    SwitchRoleEvent.switchRole(
                                      RolesModel(role: newRole),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => BlocBuilder<SignOutBloc, SignOutState>(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      text: 'Cancel',
                      isDisabled: isLoading,
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Logout',
                      isLoading: isLoading,
                      onPressed: () {
                        sl<SignOutBloc>().add(const SignOutEvent.signOut());
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

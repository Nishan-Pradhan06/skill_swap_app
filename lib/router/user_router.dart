import 'package:skill_swap/common/extension/extension.dart';
import 'package:skill_swap/features/mentor/teach/pages/mentor_posts_screen.dart';
import 'package:skill_swap/features/mentor/teach/pages/skill_post_form_screen.dart';
import 'package:skill_swap/features/mentor/home/screens/mentor_all_skills_screen.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/learner/home/screen/skill_card_details_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/profile_setup_screen.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/features/profile/bloc/get_public_profile/get_public_profile_bloc.dart';
import 'package:skill_swap/features/profile/screen/public_profile_screen.dart';
import 'package:skill_swap/features/reward/blocs/reward_bloc.dart';

import '../features/shared/bottom_nav_bar/screens/learner_bottom_nav_bar.dart';
import '../features/shared/bottom_nav_bar/screens/mentor_bottom_nav_bar.dart';
import 'package:skill_swap/features/reward/screens/daily_reward_screen.dart';
import 'package:skill_swap/features/purchase_point/pages/purchase_point_screen.dart';

List<GoRoute> userAppRoutes = [
  GoRoute(
    path: AppRoutesName.profileSetupScreenRoute.path,
    name: AppRoutesName.profileSetupScreenRoute,
    builder: (context, state) => ProfileSetupFlow(),
  ),
  GoRoute(
    path: AppRoutesName.learnerBottomNavBar.path,
    name: AppRoutesName.learnerBottomNavBar,
    builder: (context, state) => LearnerBottomNavBarScreen(),
  ),
  GoRoute(
    path: AppRoutesName.mentorBottomNavBar.path,
    name: AppRoutesName.mentorBottomNavBar,
    builder: (context, state) => MentorBottomNavBarScreen(),
  ),
  GoRoute(
    path: AppRoutesName.skillCardDetails.path,
    name: AppRoutesName.skillCardDetails,
    builder: (context, state) =>
        SkillCardDetailsScreen(post: state.extra as SkillSwapPostModel),
  ),
  GoRoute(
    path: AppRoutesName.mentorPostsRoute.path,
    name: AppRoutesName.mentorPostsRoute,
    builder: (context, state) => const MentorPostsScreen(),
  ),
  GoRoute(
    path: AppRoutesName.skillPostFormRoute.path,
    name: AppRoutesName.skillPostFormRoute,
    builder: (context, state) =>
        SkillPostFormScreen(post: state.extra as SkillSwapPostModel?),
  ),
  GoRoute(
    path: AppRoutesName.dailyRewardScreenRoute.path,
    name: AppRoutesName.dailyRewardScreenRoute,
    builder: (context, state) => BlocProvider(
      create: (context) => sl<RewardBloc>(),
      child: const DailyRewardScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutesName.purchasePointScreenRoute.path,
    name: AppRoutesName.purchasePointScreenRoute,
    builder: (context, state) => const PurchasePointScreen(),
  ),
  GoRoute(
    path: AppRoutesName.mentorAllSkillsRoute.path,
    name: AppRoutesName.mentorAllSkillsRoute,
    builder: (context, state) => const MentorAllSkillsScreen(),
  ),
  GoRoute(
    path: '${AppRoutesName.publicProfileRoute.path}/:userId',
    name: AppRoutesName.publicProfileRoute,
    builder: (context, state) {
      final userId = int.parse(state.pathParameters['userId']!);
      return BlocProvider(
        create: (context) =>
            sl<GetPublicProfileBloc>()
              ..add(GetPublicProfileEvent.getProfile(userId)),
        child: const PublicProfileScreen(),
      );
    },
  ),
];

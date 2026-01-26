import 'package:skill_swap/common/extension/extension.dart';
import 'package:skill_swap/features/mentor/teach/pages/mentor_posts_screen.dart';
import 'package:skill_swap/features/mentor/teach/pages/skill_post_form_screen.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/learner/home/screen/skill_card_details_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/profile_setup_screen.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:go_router/go_router.dart';

import '../features/shared/bottom_nav_bar/screens/learner_bottom_nav_bar.dart';
import '../features/shared/bottom_nav_bar/screens/mentor_bottom_nav_bar.dart';

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
];

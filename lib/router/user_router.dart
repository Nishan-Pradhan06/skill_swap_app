import 'package:go_router/go_router.dart';
import 'package:skill_swap/common/extension/extension.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/profile_setup_screen.dart';
import 'package:skill_swap/router/app_routes_names.dart';

import '../features/shared/bottom_nav_bar/screens/learner_bottom_nav_bar.dart';

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
];

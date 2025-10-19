import 'package:go_router/go_router.dart';
import 'package:skill_swap/common/extension/extension.dart';
import 'package:skill_swap/features/shared/on_boarding/screen/on_boarding_screen.dart';

import '../features/shared/splash_screen/splash_screen.dart';
import 'app_routes_names.dart';

List<GoRoute> sharedAppRoutes = [
  GoRoute(
    path: AppRoutesName.splashScreenRoute.path,
    name: AppRoutesName.splashScreenRoute,
    builder: (context, state) => SplashScreen(),
  ),
  GoRoute(
    path: AppRoutesName.onBoardingScreen.path,
    name: AppRoutesName.onBoardingScreen,
    builder: (context, state) => OnBoardingScreen(),
  ),
];

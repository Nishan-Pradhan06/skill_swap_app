import 'package:go_router/go_router.dart';
import 'package:skill_swap/common/extension/extension.dart';

import '../features/splash_screen/splash_screen.dart';
import 'app_routes_names.dart';

List<GoRoute> sharedAppRoutes = [
  GoRoute(
    path: AppRoutesName.splashScreenRoute.path,
    name: AppRoutesName.splashScreenRoute,
    builder: (context, state) => SplashScreen(),
  ),
];

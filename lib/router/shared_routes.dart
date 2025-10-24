import 'package:go_router/go_router.dart';
import 'package:skill_swap/common/extension/extension.dart';
import 'package:skill_swap/features/auth/screens/forget_password_screen.dart';
import 'package:skill_swap/features/auth/screens/sign_in_screen.dart';
import 'package:skill_swap/features/auth/screens/sign_up_screen.dart';
import 'package:skill_swap/features/shared/on_boarding/screen/on_boarding_screen.dart';
import '../core/di/dependency_injection.dart';
import '../core/services/once_cache_service.dart';
import '../features/auth/screens/auth_option_screen.dart';
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
    redirect: (context, state) async {
      final isOnBoardingCompleted = await sl<OnceCacheService>()
          .getOnBoardingCache();
      if (isOnBoardingCompleted != null) {
        return AppRoutesName.authOptionScreenRoute.path;
      }
      return null;
    },
    builder: (context, state) => OnBoardingScreen(),
  ),
  GoRoute(
    path: AppRoutesName.authOptionScreenRoute.path,
    name: AppRoutesName.authOptionScreenRoute,
    builder: (context, state) => AuthOptionScreen(),
  ),
  GoRoute(
    path: AppRoutesName.authSignInScreenRoute.path,
    name: AppRoutesName.authSignInScreenRoute,
    builder: (context, state) => SignInScreen(),
  ),
  GoRoute(
    path: AppRoutesName.authSignUpScreenRoute.path,
    name: AppRoutesName.authSignUpScreenRoute,
    builder: (context, state) => SignUpScreen(),
  ),
  GoRoute(
    path: AppRoutesName.authForgetPasswordScreenRoute.path,
    name: AppRoutesName.authForgetPasswordScreenRoute,
    builder: (context, state) => ForgetPasswordScreen(),
  ),
];

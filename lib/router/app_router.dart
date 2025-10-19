import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/common/extension/extension.dart';
import 'admin_routes.dart';
import 'app_routes_names.dart';
import 'shared_routes.dart';
import 'user_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigatorKey',
);
final appRoute = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutesName.splashScreenRoute.path,
  routes: [...sharedAppRoutes, ...userAppRoutes, ...adminAppRoutes],
);

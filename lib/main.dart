import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'core/config/env_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/services/once_cache_service.dart';
import 'features/shared/on_boarding/cubit/on_boarding_cubit.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig.initialize(Environment.development);

  await setupServiceLocator();

  await sl<OnceCacheService>().init();

  runApp(const SkillSwap());
}

class SkillSwap extends StatelessWidget {
  const SkillSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<OnBoardingCubit>())],
      child: MaterialApp.router(
        title: 'Skill Swap',
        debugShowCheckedModeBanner: false,
        routerConfig: appRoute,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

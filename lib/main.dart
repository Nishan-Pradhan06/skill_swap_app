import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/features/auth/bloc/bloc/sign_out_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_in/sign_in_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:skill_swap/features/profile/cubit/theme_appearance_cubit.dart';
import 'core/config/env_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/services/cache_service.dart';
import 'core/services/once_cache_service.dart';
import 'features/shared/on_boarding/cubit/on_boarding_cubit.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  EnvConfig.initialize(Environment.development);

  log(EnvConfig.instance.apiBaseUrl);

  await setupServiceLocator();

  //Global SharedPreferences
  await CacheServices.instance.init();

  await sl<OnceCacheService>().init();

  runApp(const SkillSwap());
}

class SkillSwap extends StatelessWidget {
  const SkillSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<OnBoardingCubit>()),
        BlocProvider(
          create: (_) =>
              ThemeAppearanceCubit(onceCacheService: sl<OnceCacheService>()),
        ),
        BlocProvider(create: (_) => sl<SignInBloc>()),
        BlocProvider(create: (_) => sl<SignUpBloc>()),
        BlocProvider(create: (_) => sl<ProfileSetupBloc>()),
        BlocProvider(create: (_) => sl<GetProfileBloc>()),
        BlocProvider(create: (_) => sl<SignOutBloc>()),
        BlocProvider(create: (_) => sl<GetNotificationBloc>()),
      ],
      child: BlocBuilder<ThemeAppearanceCubit, ThemeAppearanceState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Skill Swap',
            debugShowCheckedModeBanner: false,
            routerConfig: appRoute,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.selectedThemeMode,
          );
        },
      ),
    );
  }
}

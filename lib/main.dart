import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/features/profile/cubit/theme_appearance_cubit.dart';
import 'core/config/env_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/services/cache_service.dart';
import 'core/services/once_cache_service.dart';
import 'core/widgets/bloc_wrapper_widget.dart';
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
    return BlocWrapperWidget(
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

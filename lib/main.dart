import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/features/profile/cubit/theme_appearance_cubit.dart';
import 'core/init/app_initilizer.dart';
import 'core/widgets/bloc_wrapper_widget.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app with router for push notification navigation
  await AppInitializer.init(router: appRoute);

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

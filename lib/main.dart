import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/config/env_config.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig.initialize(Environment.development);

  runApp(const SkillSwap());
}

class SkillSwap extends StatelessWidget {
  const SkillSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Skill Swap',
      debugShowCheckedModeBanner: false,
      routerConfig: appRoute,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }
}

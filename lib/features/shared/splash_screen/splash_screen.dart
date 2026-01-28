import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:skill_swap/features/profile/bloc/profile_completion_check/profile_completion_check_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/services/cache_service.dart';
import '../../../router/app_routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInLottie;
  late Animation<double> _fadeInText;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Fade-in animation for Lottie (first 60% of total duration)
    _fadeInLottie = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    );

    // Fade-in animation for text (starts after Lottie begins)
    _fadeInText = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();
    _navigate(); // Uncomment when navigation is ready
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ...existing code...
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final token = await CacheServices.instance.getAuthToken();

    // Not signed in → show onboarding/login
    if (token == null || token.isEmpty) {
      if (mounted) {
        context.goNamed(AppRoutesName.onBoardingScreen);
      }
      return;
    }

    // Signed in → check profile completion from backend
    final bloc = sl<ProfileCompletionCheckBloc>();
    bloc.add(const ProfileCompletionCheckEvent.checkProfileCompletion());

    await for (final state in bloc.stream) {
      if (!mounted) return;

      state.whenOrNull(
        loaded: (data) {
          if (!data.isComplete) {
            // Profile incomplete → redirect to setup
            if (mounted) {
              context.goNamed(AppRoutesName.profileSetupScreenRoute);
            }
          } else {
            // Profile complete → navigate based on role
            _navigateToHomeByRole();
          }
        },
        failure: (failure) {
          // On error, fallback to onboarding
          if (mounted) {
            context.goNamed(AppRoutesName.onBoardingScreen);
          }
        },
      );

      // Break after first non-initial state
      break;
    }
  }

  Future<void> _navigateToHomeByRole() async {
    final role = await CacheServices.instance.getUserRole();

    if (!mounted) return;

    if (role == 'LEARNER') {
      context.goNamed(AppRoutesName.learnerBottomNavBar);
    } else if (role == 'MENTOR') {
      context.goNamed(AppRoutesName.mentorBottomNavBar);
    } else if (role == 'ADMIN') {
      // context.goNamed(AppRoutesName.adminDashboardScreen);
      context.goNamed(AppRoutesName.onBoardingScreen);
    } else {
      // fallback
      context.goNamed(AppRoutesName.onBoardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade-in Lottie logo
            FadeTransition(
              opacity: _fadeInLottie,
              child: Lottie.asset(
                'assets/lottie/logo.json',
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Fade-in text after Lottie
            FadeTransition(
              opacity: _fadeInText,
              child: Text(
                "SkillSwap",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

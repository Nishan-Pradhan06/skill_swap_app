import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../cubit/on_boarding_cubit.dart';
import '../model/on_boarding_model.dart';
import '../widget/onboarding_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  late PageController controller;
  List<OnboardingModel> items = OnboardingData.items;

  onPageChange(int value) {
    currentPage = value;
    setState(() {});
  }

  _gotoNextPage() {
    if (currentPage < items.length - 1) {
      controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _gotoAuthOptions();
    }
  }

  _gotoAuthOptions() {
    sl<OnBoardingCubit>().setOnBoarding();
    context.goNamed(AppRoutesName.authOptionScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: PageView.builder(
              onPageChanged: onPageChange,
              itemCount: items.length,
              controller: controller,
              itemBuilder: (context, index) {
                return OnboardingView(data: items[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TweenAnimationBuilder(
                  duration: Duration(milliseconds: 500),
                  tween: Tween<double>(
                    begin: 0,
                    end: (1 / items.length) * (currentPage + 1),
                  ),
                  curve: Curves.easeInOutBack,
                  builder: (context, double value, _) => SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 2,
                    ),
                  ),
                ),

                SizedBox(
                  height: 75,
                  width: 75,
                  child: ElevatedButton(
                    onPressed: _gotoNextPage,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

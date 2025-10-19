import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      _gotoLoginSignUp();
    }
  }

  _gotoLoginSignUp() {
    // Navigator.pushNamed(context, AppRoutes.introLogin);
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
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
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
            const Spacer(),
            Stack(
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
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      // backgroundColor: AppColors.cardColor,
                      // color: AppColors.primary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _gotoNextPage,
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  child: SvgPicture.asset('assets/svg/icons/arrow_forward.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

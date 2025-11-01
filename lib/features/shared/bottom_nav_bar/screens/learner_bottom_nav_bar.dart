import 'package:flutter/material.dart';
import 'package:skill_swap/features/learner/home/screen/learner_home_screen.dart';
import 'package:skill_swap/features/learner/menu/screen/learner_menu_screen.dart';
import 'package:skill_swap/features/learner/my_learning/screen/learner_my_learning_screen.dart';
import 'package:skill_swap/features/learner/search/screen/learner_search_screen.dart';
import 'package:skill_swap/features/learner/swap/screen/learner_swap_screen.dart';
import '../../../../core/widgets/double_press_to_exit.dart';

class LearnerBottomNavBarScreen extends StatefulWidget {
  const LearnerBottomNavBarScreen({super.key});
  @override
  State<LearnerBottomNavBarScreen> createState() =>
      _LearnerBottomNavBarScreenState();
}

class _LearnerBottomNavBarScreenState extends State<LearnerBottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LearnerHomeScreen(),
    LearnerSearchScreen(),
    LearnerSwapScreen(),
    LearnerMyLearningScreen(),
    LearnerMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: Material(
          elevation: 8,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill_rounded),
                label: 'My Learning',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz_rounded),
                label: 'Swap',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.comment_rounded),
                label: 'Conversation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps_rounded),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/learner/home/screen/learner_home_screen.dart';
import 'package:skill_swap/features/shared/menu/screen/learner_menu_screen.dart';
import 'package:skill_swap/features/learner/my_learning/screen/learner_my_learning_screen.dart';
import 'package:skill_swap/features/learner/swap/screen/learner_swap_screen.dart';
import 'package:skill_swap/features/notifications/bloc/get_notification_count/get_notification_count_bloc.dart';
import '../../../../core/widgets/double_press_to_exit.dart';
import '../../../notifications/screens/notification_screen.dart';

class MentorBottomNavBarScreen extends StatefulWidget {
  const MentorBottomNavBarScreen({super.key});
  @override
  State<MentorBottomNavBarScreen> createState() =>
      _MentorBottomNavBarScreenState();
}

class _MentorBottomNavBarScreenState extends State<MentorBottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LearnerHomeScreen(),
    LearnerMyLearningScreen(),
    LearnerSwapScreen(),
    NotificationsPage(),
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
                label: 'My Course',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz_rounded),
                label: 'Swap',
              ),
              BottomNavigationBarItem(
                icon: IconWithCount(),
                label: 'Notifications',
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

class IconWithCount extends StatelessWidget {
  const IconWithCount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotificationCountBloc, GetNotificationCountState>(
      builder: (context, state) {
        int count = 0;

        state.whenOrNull(
          loaded: (value) {
            count = value;
          },
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_rounded),

            if (count > 0)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorScheme.of(
                      context,
                    ).errorContainer.withValues(alpha: .9),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

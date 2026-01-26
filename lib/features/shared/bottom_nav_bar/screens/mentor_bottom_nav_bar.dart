import 'package:flutter/material.dart';
import 'package:skill_swap/features/shared/menu/screen/learner_menu_screen.dart';
import '../../../../core/widgets/double_press_to_exit.dart';
import '../../../mentor/home/mentor_home_screen.dart';
import '../../../mentor/my_students/my_students_screen.dart';
import '../../../mentor/requests/request_screen.dart';
import '../../../notifications/screens/notification_screen.dart';
import '../widget/custom_icon_with_count.dart';

class MentorBottomNavBarScreen extends StatefulWidget {
  const MentorBottomNavBarScreen({super.key});
  @override
  State<MentorBottomNavBarScreen> createState() =>
      _MentorBottomNavBarScreenState();
}

class _MentorBottomNavBarScreenState extends State<MentorBottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MentorHomeScreen(),
    const MyStudentsScreen(),
    const MentorRequestsScreen(),
    const NotificationsPage(),
    const LearnerMenuScreen(),
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
                label: 'My Students',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions_rounded),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: IconWithCount(icon: Icons.notifications_rounded),
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

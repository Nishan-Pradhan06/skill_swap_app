import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/double_press_to_exit.dart';

class UserBottomNavBarScreen extends StatefulWidget {
  const UserBottomNavBarScreen({super.key});
  @override
  State<UserBottomNavBarScreen> createState() => _UserBottomNavBarScreenState();
}

class _UserBottomNavBarScreenState extends State<UserBottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('home')),
    Center(child: Text('home')),
    Center(child: Text('home')),
    Center(child: Text('home')),
    Center(child: Text('home')),
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: Material(
          elevation: 8,
          child: BottomNavigationBar(
            backgroundColor: Color(0xFFFFFFFF),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/home.svg'),
                activeIcon: SvgPicture.asset('assets/svg/home_bold.svg'),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/journal.svg'),
                activeIcon: SvgPicture.asset('assets/svg/journal_bold.svg'),
                label: 'Journal',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/library.svg'),
                activeIcon: SvgPicture.asset('assets/svg/library_bold.svg'),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/session.svg'),
                activeIcon: SvgPicture.asset('assets/svg/session_bold.svg'),
                label: 'Session',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/profile.svg'),
                activeIcon: SvgPicture.asset('assets/svg/profile_bold.svg'),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

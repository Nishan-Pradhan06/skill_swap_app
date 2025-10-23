import 'package:flutter/material.dart';
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
                icon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz_rounded),
                label: 'Swap',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill_rounded),
                label: 'My Learning',
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

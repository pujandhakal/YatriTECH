import 'package:flutter/material.dart';
import 'package:yatritech/screens/user/dashboard_screen.dart';
import 'package:yatritech/screens/user/map_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  //List of screens
  final List<Widget> _screens = [DashboardScreen(), MapScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }

  Widget _buildNavButtons(int index, IconData icon, String label) {
    bool isActive = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

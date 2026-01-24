import 'package:flutter/material.dart';
import 'package:yatritech/screens/user/analytics_screen.dart';
import 'package:yatritech/screens/user/dashboard_screen.dart';
import 'package:yatritech/screens/user/journey_screen.dart';
import 'package:yatritech/screens/user/map_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  //List of screens
  final List<Widget> _screens = [
    MapScreen(),
    DashboardScreen(),
    JourneyScreen(),
    AnalyticsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xff155DFC),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildNavButtons(Icon(Icons.map_outlined), "Navigate"),
          _buildNavButtons(Icon(Icons.dashboard_outlined), "Dashboard"),
          _buildNavButtons(Icon(Icons.schedule_outlined), "Journey"),
          _buildNavButtons(Icon(Icons.analytics_outlined), "Analytics"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavButtons(Widget icon, String label) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}

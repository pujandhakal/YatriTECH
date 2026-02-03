import 'package:flutter/material.dart';

class ProfileSidebarScreen extends StatefulWidget {
  const ProfileSidebarScreen({super.key});

  @override
  State<ProfileSidebarScreen> createState() => _ProfileSidebarScreenState();
}

class _ProfileSidebarScreenState extends State<ProfileSidebarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(35, 0, 0, 0),
                    offset: Offset(0, 10),
                    spreadRadius: 15,
                    blurRadius: -3,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(35, 0, 0, 0),
                    offset: Offset(0, 4),
                    spreadRadius: 6,
                    blurRadius: -4,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Color(0xff343A40), size: 20),
            ),
            UserAccountsDrawerHeader(
              accountName: Text("Pujan Dhakal"),
              accountEmail: Text("dhakalpujan72@gmail.com"),
            ),
          ],
        ),
      ),
    );
  }
}

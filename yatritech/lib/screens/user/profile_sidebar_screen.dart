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
            UserAccountsDrawerHeader(accountName: Text("Pujan Dhakal"), accountEmail: Text("dhakalpujan72@gmail.com"))
          ],
        ),
      ),
    );
  }
}












import 'package:flutter/material.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Logo
          Text(
            "Welcome Back",
            style: TextStyle(fontSize: 30, color: Color(0xff343A40)),
          ),
          SizedBox(height: 20),
          Text(
            "Sign in to your safety platform",
            style: TextStyle(fontSize: 16, color: Color(0xff6C757D)),
          ),
        ],
      ),
    );
  }
}

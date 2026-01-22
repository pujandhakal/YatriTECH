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

          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0, 8),
                  blurRadius: 32,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromARGB(40, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff343A40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

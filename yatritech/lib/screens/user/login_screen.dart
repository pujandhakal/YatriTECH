import 'package:flutter/material.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  GradientIconCard(icon: Icons.bolt_outlined, size: 80),
                  Text("YatriTECH", style: TextStyle(fontSize: 30)),
                  Text(
                    "Smarter Traffic. Safer Rides.",
                    style: TextStyle(fontSize: 16, color: Color(0xff4A5565)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

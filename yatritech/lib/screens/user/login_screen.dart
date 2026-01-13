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

                  SizedBox(height: 32),
                  Text("Mobile Number"),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffF3F4F6),
                          border: Border.all(color: Color(0xffE5E7EB)),
                        ),
                        child: Text("+977"),
                      ),

                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [Icon(Icons.phone), Text("9769786820")],
                        ),
                      ),
                    ],
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

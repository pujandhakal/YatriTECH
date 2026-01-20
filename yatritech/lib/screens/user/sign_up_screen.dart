import 'package:flutter/material.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0, 25),
                  blurRadius: 50,
                  spreadRadius: -12,
                ),
              ],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      GradientIconCard(icon: Icons.bolt_outlined, size: 80),
                      SizedBox(height: 12),
                      Text("YatriTECH", style: TextStyle(fontSize: 30)),
                      SizedBox(height: 18),
                      Text(
                        "Smarter Traffic. Safer Rides.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff4A5565),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),
                Text(
                  "Mobile Number",
                  style: TextStyle(color: Color(0xff364153)),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
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
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            size: 20,
                            color: Color(0xff99A1AF),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xffE5E7EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xffE5E7EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xffE5E7EB)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Color(0xff155DFC), Color(0xff4F39F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Send OTP", style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: 16,
                      color: Color(0xff4A5565),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Login with Email",
                      style: TextStyle(fontSize: 14, color: Color(0xff4A5565)),
                    ),
                  ],
                ),

                SizedBox(height: 32),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffF0FDF4),
                    border: Border.all(color: Color(0xffDCFCE7)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                            colors: [Color(0xff00C950), Color(0xff009966)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(Icons.lock_outline, size: 16),
                      ),

                      SizedBox(width: 12),
                      Text(
                        "Your data is secure and never shared without consent",
                        style: TextStyle(color: Color(0xff364153)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff155DFC),
                      ),
                      child: Icon(
                        Icons.check_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "I agree to the ",
                      style: TextStyle(color: Color(0xff4A5565)),
                    ),
                    Text(
                      "Terms of Service ",
                      style: TextStyle(color: Color(0xff155DFC)),
                    ),
                    Text("and", style: TextStyle(color: Color(0xff4A5565))),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(color: Color(0xff155DFC)),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.help, size: 16, color: Color(0xff4A5565)),
                        SizedBox(width: 8),
                        Text(
                          "Help & Support",
                          style: TextStyle(color: Color(0xff4A5565)),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.language_outlined),
                        Text(
                          "नेपाली",
                          style: TextStyle(color: Color(0xff4A5565)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

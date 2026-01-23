import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatritech/screens/user/bottom_nav.dart';
import 'package:yatritech/screens/user/sign_up_screen.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Logo
          SizedBox(height: 12),
          Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.7,
            child: SvgPicture.asset('assets/YatriConnectLogo.svg'),
          ),
          RichText(
            text: TextSpan(
              text: "Yatri",
              style: GoogleFonts.varelaRound(
                fontSize: 45,
                color: Color(0xff1E5FA1),
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: "Tech",
                  style: TextStyle(color: Color(0xff2FB8C8)),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xff343A40),
              fontWeight: FontWeight.w700,
            ),
          ),

          // SizedBox(height: 20),
          // Text(
          //   "Sign in to your safety platform",
          //   style: TextStyle(fontSize: 16, color: Color(0xff6C757D)),
          // ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(25, 0, 0, 0),
                  offset: Offset(0, 8),
                  blurRadius: 32,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromARGB(25, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff343A40),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "dhakalpujan72@gmail.com",
                    hintStyle: TextStyle(
                      color: Color(0xffADB5BD),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: Color(0xff6C757D),
                    ),
                    filled: true,
                    fillColor: Color(0xffE9ECEF).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff343A40),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      color: Color(0xffADB5BD),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Color(0xff6C757D),
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_outlined,
                      size: 20,
                      color: Color(0xff6C757D),
                    ),
                    filled: true,
                    fillColor: Color(0xffE9ECEF).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xffE9ECEF).withOpacity(0.5),
                              border: Border.all(
                                color: Color(0xffADB5BD),
                                width: 1.18,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: rememberMe
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Color(0xff343A40),
                                  )
                                : null,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff343A40),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4DA8DA),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff4DA8DA), Color(0xff73C2FB)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff4DA8DA).withOpacity(0.3),
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: -3,
                      ),
                      BoxShadow(
                        color: Color(0xff4DA8DA).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onDoubleTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNav()),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(color: Color(0xffDEE2E6), thickness: 1.18),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6C757D),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xffE9ECEF).withOpacity(0.5),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.18,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // Face ID / Touch ID action
                      },
                      child: Center(
                        child: Text(
                          "🔐 Face ID / Touch ID",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff343A40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(fontSize: 16, color: Color(0xff6C757D)),
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: TextStyle(
                      color: Color(0xff4DA8DA),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatritech/screens/user/bottom_nav.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yatriTECH',
      theme: ThemeData(textTheme: GoogleFonts.varelaRoundTextTheme()),
      debugShowCheckedModeBanner: false,
      home: BottomNav(),
    );
  }
}

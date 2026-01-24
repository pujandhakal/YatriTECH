import 'package:flutter/material.dart';
import 'package:yatritech/reusable/settings/settings_fifth_card.dart';
import 'package:yatritech/reusable/settings/settings_first_card.dart';
import 'package:yatritech/reusable/settings/settings_fourth_card.dart';
import 'package:yatritech/reusable/settings/settings_second_card.dart';
import 'package:yatritech/reusable/settings/settings_seventh_card.dart';
import 'package:yatritech/reusable/settings/settings_sixth_card.dart';
import 'package:yatritech/reusable/settings/settings_third_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 40.9,
            height: 40.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff4DA8DA), Color(0xff73C2FB)],
              ),
              border: Border.all(
                color: Color(0xFFFFFFFF).withOpacity(0.5),
                width: 1.54,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipOval(
                  child: Image.network(
                    "https://picsum.photos/240",
                    width: 40.9,
                    height: 40.9,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff51CF66),
                      border: Border.all(color: Colors.white, width: 1.18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff343A40),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Device, alerts, and privacy controls",
                style: TextStyle(color: Color(0xff6C757D), fontSize: 16),
              ),
              SizedBox(height: 32),
              SettingsFirstCard(),
              SizedBox(height: 16),
              SettingsSecondCard(),
              SizedBox(height: 16),
              SettingsThirdCard(),
              SizedBox(height: 16),
              SettingsFourthCard(),
              SizedBox(height: 16),
              SettingsFifthCard(),
              SizedBox(height: 16),
              SettingsSixthCard(),
              SizedBox(height: 16),
              SettingsSeventhCard(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsSeventhCard extends StatefulWidget {
  const SettingsSeventhCard({super.key});

  @override
  State<SettingsSeventhCard> createState() => _SettingsSeventhCardState();
}

class _SettingsSeventhCardState extends State<SettingsSeventhCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xFFFFFFFF).withOpacity(0.7),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          // color: Color(0xFFFFFFFF).withOpacity(0.4),
          color: Colors.transparent,

          width: 1.18,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     blurRadius: 32,
        //     offset: Offset(0, 8),
        //   ),
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.04),
        //     blurRadius: 8,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      padding: EdgeInsets.all(25.172),
      child: Column(
        children: [
          Text(
            "YatriTech - Smart Mobility Platform",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff6C757D),
              height: 1.43,
            ),
          ),
          SizedBox(height: 7.985),
          Text(
            "Version 1.0.0",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff343A40),
              height: 1.5,
            ),
          ),
          SizedBox(height: 7.985),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.developer_board,
                size: 13.997,
                color: Color(0xff6C757D),
              ),
              SizedBox(width: 2),
              Text(
                "ESP32",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff6C757D),
                  height: 1.33,
                ),
              ),
              SizedBox(width: 6),
              Text(
                "•",
                style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.location_on_outlined,
                size: 13.997,
                color: Color(0xff6C757D),
              ),
              SizedBox(width: 2),
              Text(
                "NEO-6M GPS",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff6C757D),
                  height: 1.33,
                ),
              ),
              SizedBox(width: 6),
              Text(
                "•",
                style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
              ),
              SizedBox(width: 6),
              Icon(Icons.sensors, size: 13.997, color: Color(0xff6C757D)),
              SizedBox(width: 2),
              Text(
                "MPU6050 IMU",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff6C757D),
                  height: 1.33,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

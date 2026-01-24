import 'package:flutter/material.dart';

class SettingsSixthCard extends StatefulWidget {
  const SettingsSixthCard({super.key});

  @override
  State<SettingsSixthCard> createState() => _SettingsSixthCardState();
}

class _SettingsSixthCardState extends State<SettingsSixthCard> {
  Widget _buildSensorReading({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      height: 43.964,
      decoration: BoxDecoration(
        color: Color(0xFFE9ECEF).withOpacity(0.3),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsets.symmetric(horizontal: 11.987),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 15.989, color: iconColor),
              SizedBox(width: 7.985),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff6C757D),
                  height: 1.33,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Color(0xff343A40),
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Color(0xFFFFFFFF).withOpacity(0.4),
          width: 1.18,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 47.966,
                height: 47.966,
                decoration: BoxDecoration(
                  color: Color(0xff6ACFCF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.monitor_heart_outlined,
                  size: 23.992,
                  color: Color(0xff6ACFCF),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Live Sensor Data",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.56,
                      color: Color(0xff343A40),
                    ),
                  ),
                  Text(
                    "Real-time readings from MPU6050",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.43,
                      color: Color(0xff6C757D),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 19.99),
          _buildSensorReading(
            icon: Icons.show_chart,
            iconColor: Color(0xff4DA8DA),
            label: "Acceleration (X/Y/Z)",
            value: "0.12g / -0.05g / 1.02g",
          ),
          SizedBox(height: 15.989),
          _buildSensorReading(
            icon: Icons.wifi_protected_setup,
            iconColor: Color(0xff9775FA),
            label: "Gyroscope (X/Y/Z)",
            value: "2.1° / -0.8° / 0.3°",
          ),
          SizedBox(height: 15.989),
          _buildSensorReading(
            icon: Icons.thermostat_outlined,
            iconColor: Color(0xFFFFB547),
            label: "Temperature",
            value: "28.5°C",
          ),
        ],
      ),
    );
  }
}

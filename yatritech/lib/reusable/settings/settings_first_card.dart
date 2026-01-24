import 'package:flutter/material.dart';

class SettingsFirstCard extends StatefulWidget {
  const SettingsFirstCard({super.key});

  @override
  State<SettingsFirstCard> createState() => _SettingsFirstCardState();
}

class _SettingsFirstCardState extends State<SettingsFirstCard> {
  String _selectedState = "GPS Active";

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
      padding: EdgeInsets.all(25.172),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 47.966,
                height: 47.966,
                decoration: BoxDecoration(
                  color: Color(0xff4DA8DA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.router_outlined,
                  size: 23.992,
                  color: Color(0xff4DA8DA),
                ),
              ),
              SizedBox(width: 11.987),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Device Status",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.56,
                      color: Color(0xff343A40),
                    ),
                  ),
                  Text(
                    "Hardware & connectivity",
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

          // Device Status Rows
          _buildDeviceRow(
            icon: Icons.wifi_outlined,
            title: "ESP32 Controller",
            status: "Connected",
            description: "Main processing unit",
          ),
          SizedBox(height: 11.987),
          _buildDeviceRow(
            icon: Icons.location_on_outlined,
            title: "GPS (NEO-6M)",
            status: "Active • 12 satellites",
            description: "Location tracking",
          ),
          SizedBox(height: 11.987),
          _buildDeviceRow(
            icon: Icons.sensors_outlined,
            title: "Motion Sensor (MPU6050)",
            status: "Active • 100Hz",
            description: "Accelerometer + Gyroscope",
          ),
          SizedBox(height: 17.169),

          // Divider
          Container(height: 1.18, color: Color(0xFFFFFFFF).withOpacity(0.4)),
          SizedBox(height: 17.169),

          // Sensor States
          Text(
            "Sensor States:",
            style: TextStyle(
              fontSize: 12,
              height: 1.33,
              color: Color(0xff6C757D),
            ),
          ),
          SizedBox(height: 11.987),
          Row(
            children: [
              _buildStateButton(
                label: "Active",
                color: Color(0xff51CF66),
                textColor: Color(0xff2F9E44),
              ),
              SizedBox(width: 7.985),
              _buildStateButton(
                label: "Fallback",
                color: Color(0xffFFB547),
                textColor: Color(0xffE67700),
              ),
              SizedBox(width: 7.985),
              _buildStateButton(
                label: "Off",
                color: Color(0xffFF6B6B),
                textColor: Color(0xffE03131),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceRow({
    required IconData icon,
    required String title,
    required String status,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff51CF66).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xff51CF66).withOpacity(0.3),
          width: 1.18,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17.169, vertical: 17.169),
      child: Row(
        children: [
          Container(
            width: 33.969,
            height: 33.969,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withOpacity(0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 17.999, color: Color(0xff51CF66)),
          ),
          SizedBox(width: 11.987),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.43,
                        color: Color(0xff343A40),
                      ),
                    ),
                    Container(
                      width: 7.985,
                      height: 7.985,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff51CF66),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.983),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.33,
                    color: Color(0xff343A40),
                  ),
                ),
                SizedBox(height: 3.983),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.5,
                    color: Color(0xff6C757D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateButton({
    required String label,
    required Color color,
    required Color textColor,
  }) {
    final isSelected = _selectedState == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedState = label;
        });
      },
      child: Container(
        height: 34.338,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3), width: 1.18),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.33,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

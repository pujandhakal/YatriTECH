import 'package:flutter/material.dart';

class SettingsFifthCard extends StatefulWidget {
  const SettingsFifthCard({super.key});

  @override
  State<SettingsFifthCard> createState() => _SettingsFifthCardState();
}

class _SettingsFifthCardState extends State<SettingsFifthCard> {
  bool _isExpanded = false;
  bool _usageAnalytics = true;
  bool _locationHistory = true;
  bool _journeySharing = true;
  bool _backgroundLocation = true;
  bool _crashDataEncryption = true;

  Widget _buildToggleOption({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff343A40),
                    height: 1.43,
                  ),
                ),
                SizedBox(height: 3.983),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff6C757D),
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.989),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: 55.988,
              height: 31.996,
              decoration: BoxDecoration(
                color: value ? Color(0xff51CF66) : Color(0xFFE9ECEF),
                borderRadius: BorderRadius.circular(39602500),
              ),
              padding: EdgeInsets.symmetric(horizontal: 1.996, vertical: 3.983),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 23.992,
                height: 23.992,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(39602500),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Container(
      height: 70.335,
      decoration: BoxDecoration(
        color: Color(0xFFE9ECEF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFFFFFFF).withOpacity(0.4),
          width: 1.18,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17.169, vertical: 1.18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 33.969,
                height: 33.969,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 17.999, color: color),
              ),
              SizedBox(width: 11.987),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff343A40),
                      height: 1.43,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff6C757D),
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing ??
              Icon(Icons.chevron_right, size: 15.989, color: Color(0xff6C757D)),
        ],
      ),
    );
  }

  Widget _buildManagementButton({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      height: 70.335,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.18),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17.169, vertical: 1.18),
      child: Row(
        children: [
          Icon(icon, size: 17.999, color: iconColor),
          SizedBox(width: 11.987),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.43,
                ),
              ),
              Text(
                subtitle,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
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
        padding: EdgeInsets.symmetric(horizontal: 23.992, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 47.966,
                      height: 47.966,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFFFFF).withOpacity(0.6),
                            Color(0xFFFFFFFF).withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.security,
                        size: 23.992,
                        color: Color(0xff51CF66),
                      ),
                    ),
                    SizedBox(width: 11.987),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Privacy & Sharing",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: Color(0xff343A40),
                          ),
                        ),
                        Text(
                          "Control your data",
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
                AnimatedRotation(
                  turns: _isExpanded ? 0.25 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.chevron_right,
                    size: 19.99,
                    color: Color(0xff6C757D),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        SizedBox(height: 24),
                        // Data Collection Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Data Collection",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff343A40),
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        _buildToggleOption(
                          title: "Usage Analytics",
                          subtitle:
                              "Help improve the app with anonymous usage data",
                          value: _usageAnalytics,
                          onChanged: (val) =>
                              setState(() => _usageAnalytics = val),
                        ),
                        SizedBox(height: 15.989),
                        Container(
                          height: 0.996,
                          color: Color(0xFFFFFFFF).withOpacity(0.4),
                        ),
                        SizedBox(height: 15.989),
                        // Location & Journey Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Location & Journey",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff343A40),
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        _buildToggleOption(
                          title: "Location History",
                          subtitle: "Store journey data locally for insights",
                          value: _locationHistory,
                          onChanged: (val) =>
                              setState(() => _locationHistory = val),
                        ),
                        SizedBox(height: 15.989),
                        _buildToggleOption(
                          title: "Journey Sharing",
                          subtitle:
                              "Allow sharing trips with emergency contacts",
                          value: _journeySharing,
                          onChanged: (val) =>
                              setState(() => _journeySharing = val),
                        ),
                        SizedBox(height: 15.989),
                        _buildToggleOption(
                          title: "Background Location",
                          subtitle: "Track location when app is in background",
                          value: _backgroundLocation,
                          onChanged: (val) =>
                              setState(() => _backgroundLocation = val),
                        ),
                        SizedBox(height: 15.989),
                        Container(
                          height: 0.996,
                          color: Color(0xFFFFFFFF).withOpacity(0.4),
                        ),
                        SizedBox(height: 15.989),
                        // Advanced Privacy Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Advanced Privacy",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff343A40),
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        _buildPrivacyButton(
                          icon: Icons.visibility_outlined,
                          color: Color(0xff4DA8DA),
                          title: "Visible to Emergency Contacts",
                          subtitle: "Who can see your live location",
                        ),
                        SizedBox(height: 11.987),
                        _buildPrivacyButton(
                          icon: Icons.lock_outline,
                          color: Color(0xff51CF66),
                          title: "Crash Data Encryption",
                          subtitle: "End-to-end encrypted alerts",
                          trailing: Container(
                            width: 19.99,
                            height: 19.99,
                            decoration: BoxDecoration(
                              color: Color(0xff51CF66),
                              borderRadius: BorderRadius.circular(39602500),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 13.997,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        _buildPrivacyButton(
                          icon: Icons.sensors,
                          color: Color(0xff6ACFCF),
                          title: "Sensor Data Retention",
                          subtitle: "Keep data for 90 days",
                        ),
                        SizedBox(height: 15.989),
                        Container(
                          height: 0.996,
                          color: Color(0xFFFFFFFF).withOpacity(0.4),
                        ),
                        SizedBox(height: 15.989),
                        // Data Management Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Data Management",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff343A40),
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        _buildManagementButton(
                          icon: Icons.file_download_outlined,
                          iconColor: Color(0xff4DA8DA),
                          title: "Export My Data",
                          subtitle: "Download all stored journey data",
                          backgroundColor: Color(0xff4DA8DA).withOpacity(0.1),
                          borderColor: Color(0xff4DA8DA).withOpacity(0.3),
                          textColor: Color(0xff4DA8DA),
                        ),
                        SizedBox(height: 11.987),
                        _buildManagementButton(
                          icon: Icons.cleaning_services_outlined,
                          iconColor: Color(0xFFE67700),
                          title: "Clear Cache",
                          subtitle: "Remove temporary files (234 MB)",
                          backgroundColor: Color(0xFFFFB547).withOpacity(0.1),
                          borderColor: Color(0xFFFFB547).withOpacity(0.3),
                          textColor: Color(0xFFE67700),
                        ),
                        SizedBox(height: 11.987),
                        _buildManagementButton(
                          icon: Icons.delete_outline,
                          iconColor: Color(0xFFFF6B6B),
                          title: "Delete All Journey Data",
                          subtitle: "Permanently erase location history",
                          backgroundColor: Color(0xFFFF6B6B).withOpacity(0.1),
                          borderColor: Color(0xFFFF6B6B).withOpacity(0.3),
                          textColor: Color(0xFFFF6B6B),
                        ),
                        SizedBox(height: 15.989),
                        // Privacy Notice
                        Container(
                          padding: EdgeInsets.all(15.989),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "🔒 Your Privacy Matters",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff343A40),
                                  height: 1.43,
                                ),
                              ),
                              SizedBox(height: 7.985),
                              Text(
                                "All sensor data (GPS NEO-6M, MPU6050) is processed locally on your ESP32 device. We never collect personally identifiable information. Crash and theft alerts are only sent to your configured emergency contacts. Your data stays on your device unless you explicitly choose to share it.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff6C757D),
                                  height: 1.625,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

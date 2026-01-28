import 'package:flutter/material.dart';

class CrashDetectionScreen extends StatefulWidget {
  const CrashDetectionScreen({super.key});

  @override
  State<CrashDetectionScreen> createState() => _CrashDetectionScreenState();
}

class _CrashDetectionScreenState extends State<CrashDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
                border: Border.all(color: Colors.white24),
              ),
              child: Icon(Icons.chevron_left, color: Colors.white),
            ),
          ),

          Center(
            child: Column(
              children: [
                Text(
                  "30",
                  style: TextStyle(
                    fontSize: 72,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Seconds"),
                Icon(Icons.dangerous_outlined),
                Text(
                  "Crash Detected",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Emergency Response Active",
                  style: TextStyle(
                    color: Color(0xffFF6B6B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  children: [
                    _impactContainer(
                      icon: Icons.trending_up,
                      iconColor: Color(0xffFFB547),
                      topName: "IMPACT FORCE",
                      bigName: "8.4 G",
                      bottomName: "High severity",
                    ),
                    _impactContainer(
                      icon: Icons.location_on,
                      iconColor: Color(0xff4DA8DA),
                      topName: "DIRECTION",
                      bigName: "Front-Right",
                      bottomName: "Point of impact",
                    ),
                    _impactContainer(
                      icon: Icons.shield_outlined,
                      iconColor: Color(0xffFF6B6B),
                      topName: "VEHICLE TILT",
                      bigName: "42°",
                      bottomName: "Forward angle",
                    ),
                    _impactContainer(
                      icon: Icons.shield_outlined,
                      iconColor: Color(0xffFF6B6B),
                      topName: "VEHICLE ROLL",
                      bigName: "38°",
                      bottomName: "Side angle",
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

  Container _impactContainer({
    required IconData icon,
    required Color iconColor,
    required String topName,
    required String bigName,
    required String bottomName,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff595959)),
        borderRadius: BorderRadius.circular(16),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(25, 255, 181, 71),
            Color.fromARGB(0, 0, 0, 0),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              Text(
                topName,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            bigName,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            bottomName,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

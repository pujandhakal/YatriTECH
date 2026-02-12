import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CrashDetectionScreen extends StatefulWidget {
  const CrashDetectionScreen({super.key});

  @override
  State<CrashDetectionScreen> createState() => _CrashDetectionScreenState();
}

class _CrashDetectionScreenState extends State<CrashDetectionScreen> {
  int _countdown = 30;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _playAlertSound();
  }

  Future<void> _playAlertSound() async {
    try {
      await _audioPlayer.play(AssetSource('accident_detection_sound.m4a'));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> _triggerEmergencyCall() async {
    var status = await Permission.phone.request();

    if (status.isGranted) {
      try {
        await FlutterPhoneDirectCaller.callNumber('9812776353');
      } catch (e) {
        print("Error launching call: $e");
      }
    } else {
      print("Phone Permission denied");
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        _triggerEmergencyCall();
        //trigger emergency help
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(6),
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
                      "$_countdown",
                      style: TextStyle(
                        fontSize: 72,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Seconds", style: TextStyle(color: Colors.white70)),
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xffFF6B6B),
                      size: 132,
                    ),
                    Text(
                      "Crash Detected",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Emergency Response Active",
                      style: TextStyle(
                        color: Color(0xffFF6B6B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 36),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
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
                          bigName: "Front",
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
                          icon: Icons.trending_up,
                          iconColor: Color(0xff76C484),
                          topName: "VEHICLE ROLL",
                          bigName: "38°",
                          bottomName: "Side angle",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff595959)),
                        borderRadius: BorderRadius.circular(16),

                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(25, 81, 207, 102),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Color(0xff51CF66),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "LAST KNOWN LOCATION",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            "28.6139°N, 77.2090°E",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Connaught Place, New Delhi",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "GPS signal: Strong • Accuracy: ±5m",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    //TODO: I have to make these two below buttons Sticky(FAB), nobody wants to scroll their screen while dying
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(32),
                          gradient: LinearGradient(
                            colors: [Color(0xff51CF66), Color(0xff2F9E44)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.close, color: Colors.white, size: 40),
                            Text(
                              "I AM SAFE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(32),
                          gradient: LinearGradient(
                            colors: [Color(0xffFF6B6B), Color(0xffE03131)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "SEND EMERGENCY HELP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 18),

                    Text(
                      "Auto-sending help in ${_countdown}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      "Emergency services will be contacted automatically",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      width: 162,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff595959)),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff303030),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            iconColor,
            // Color.fromARGB(25, 255, 181, 71),
            Color.fromARGB(0, 0, 0, 0),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              SizedBox(width: 4),
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
          SizedBox(height: 16),
          Text(
            bigName,
            style: TextStyle(
              fontSize: 24,
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

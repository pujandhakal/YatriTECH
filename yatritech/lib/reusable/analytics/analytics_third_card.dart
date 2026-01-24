import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalyticsThirdCard extends StatefulWidget {
  const AnalyticsThirdCard({super.key});

  @override
  State<AnalyticsThirdCard> createState() => _AnalyticsThirdCardState();
}

class _AnalyticsThirdCardState extends State<AnalyticsThirdCard> {
  bool _isExpanded = false;

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
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xffFFB547).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xffFFB547),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harsh Events",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6C757D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "25 events",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff343A40),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xff6C757D),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Bar Chart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar("Brake", 12, Color(0xffFF6B6B), 1.0),
              _buildBar("Accel", 8, Color(0xffFFB547), 0.67),
              _buildBar("Corner", 5, Color(0xff4DA8DA), 0.42),
            ],
          ),

          // Expanded Content
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFFFFFFF).withOpacity(0.4),
                              width: 1.18,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(top: 24),
                        child: Column(
                          children: [
                            _buildEventDetail(
                              "Harsh Braking",
                              "12",
                              "Sudden deceleration events detected",
                              Icons.warning_amber_rounded,
                              Color(0xffFF6B6B),
                            ),
                            SizedBox(height: 16),
                            _buildEventDetail(
                              "Harsh Acceleration",
                              "8",
                              "Rapid speed increase events",
                              Icons.speed,
                              Color(0xffFFB547),
                            ),
                            SizedBox(height: 16),
                            _buildEventDetail(
                              "Sharp Cornering",
                              "5",
                              "Aggressive turning maneuvers",
                              Icons.monitor_heart_outlined,
                              Color(0xff4DA8DA),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: Color(0xff51CF66).withOpacity(0.1),
                                border: Border.all(
                                  color: Color(0xff51CF66).withOpacity(0.3),
                                  width: 1.18,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Text("💡", style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Tip: Reduce harsh events by 30% to improve your behavior score",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2F9E44),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }

  Widget _buildEventDetail(
    String title,
    String count,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.3), width: 1.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withOpacity(0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff343A40),
                      ),
                    ),
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff343A40),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, int count, Color color, double heightFactor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff343A40),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 72 * heightFactor,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xffE9ECEF),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 72 * heightFactor,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 10, color: Color(0xff6C757D))),
        ],
      ),
    );
  }
}

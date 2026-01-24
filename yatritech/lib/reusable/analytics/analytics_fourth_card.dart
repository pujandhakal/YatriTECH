import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalyticsFourthCard extends StatefulWidget {
  const AnalyticsFourthCard({super.key});

  @override
  State<AnalyticsFourthCard> createState() => _AnalyticsFourthCardState();
}

class _AnalyticsFourthCardState extends State<AnalyticsFourthCard> {
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
                      color: Color(0xff6ACFCF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.schedule,
                      color: Color(0xff6ACFCF),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time Analysis",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6C757D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Idle vs Movement",
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

          // Donut Chart and Legend
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Donut Chart
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(160, 160),
                      painter: DonutChartPainter(
                        movementPercentage: 0.78,
                        idlePercentage: 0.22,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "78%",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff343A40),
                          ),
                        ),
                        Text(
                          "Moving",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff6C757D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 22),

              // Legend
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem(
                      "Movement",
                      "78% of total time",
                      Color(0xff51CF66),
                    ),
                    SizedBox(height: 12),
                    _buildLegendItem(
                      "Idle",
                      "22% of total time",
                      Color(0xffFFB547),
                    ),
                  ],
                ),
              ),
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
                            // Time Cards
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Color(0xff51CF66).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Active Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "5h 14m",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff343A40),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFB547).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Idle Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "1h 28m",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff343A40),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Efficiency Score
                            Container(
                              padding: EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: Color(0xff4DA8DA).withOpacity(0.1),
                                border: Border.all(
                                  color: Color(0xff4DA8DA).withOpacity(0.3),
                                  width: 1.18,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("⚡", style: TextStyle(fontSize: 14)),
                                      SizedBox(width: 4),
                                      Text(
                                        "Efficiency Score: Good",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1971C2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Your idle time is within optimal range. Keep it under 25% for best efficiency.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff6C757D),
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

  Widget _buildLegendItem(String title, String subtitle, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                subtitle,
                style: TextStyle(fontSize: 14, color: Color(0xff6C757D)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double movementPercentage;
  final double idlePercentage;

  DonutChartPainter({
    required this.movementPercentage,
    required this.idlePercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final strokeWidth = 20.0;

    // Movement arc (green)
    final movementPaint = Paint()
      ..color = Color(0xff51CF66)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final movementSweepAngle = 2 * math.pi * movementPercentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      movementSweepAngle,
      false,
      movementPaint,
    );

    // Idle arc (orange)
    final idlePaint = Paint()
      ..color = Color(0xffFFB547)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final idleSweepAngle = 2 * math.pi * idlePercentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + movementSweepAngle,
      idleSweepAngle,
      false,
      idlePaint,
    );
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) {
    return oldDelegate.movementPercentage != movementPercentage ||
        oldDelegate.idlePercentage != idlePercentage;
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalyticsFirstCard extends StatefulWidget {
  final String selectedTab;
  const AnalyticsFirstCard({super.key, required this.selectedTab});

  @override
  State<AnalyticsFirstCard> createState() => _AnalyticsFirstCardState();
}

class _AnalyticsFirstCardState extends State<AnalyticsFirstCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();
  }

  @override
  void didUpdateWidget(AnalyticsFirstCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTab != widget.selectedTab) {
      _animationController?.reset();
      _animationController?.forward();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Driving Behavior",
                    style: TextStyle(fontSize: 14, color: Color(0xff6C757D)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Overall Score",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff343A40),
                    ),
                  ),
                ],
              ),
              Icon(Icons.speed_outlined, color: Color(0xff4DA8DA), size: 24),
            ],
          ),
          SizedBox(height: 16),

          // Circular Progress and Metrics
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Progress
              SizedBox(
                width: 192,
                height: 192,
                child: AnimatedBuilder(
                  animation: _animation ?? AlwaysStoppedAnimation(1.0),
                  builder: (context, child) {
                    final animationValue = _animation?.value ?? 0.0;
                    final animatedProgress = 0.87 * animationValue;
                    final displayValue = (87 * animationValue).toInt();
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(192, 192),
                          painter: CircularProgressPainter(
                            progress: animatedProgress,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$displayValue",
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2F9E44),
                              ),
                            ),
                            Text(
                              "out of 100",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff6C757D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(width: 20),

              // Metrics
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation ?? AlwaysStoppedAnimation(1.0),
                  builder: (context, child) {
                    final animationValue = _animation?.value ?? 0.0;
                    return Column(
                      children: [
                        _buildMetricRow(
                          "Smooth Driving",
                          0.92 * animationValue,
                          Color(0xff51CF66),
                        ),
                        SizedBox(height: 12),
                        _buildMetricRow(
                          "Speed Control",
                          0.85 * animationValue,
                          Color(0xff4DA8DA),
                        ),
                        SizedBox(height: 12),
                        _buildMetricRow(
                          "Safe Distance",
                          0.88 * animationValue,
                          Color(0xff6ACFCF),
                        ),
                        SizedBox(height: 12),
                        _buildMetricRow(
                          "Cornering",
                          0.82 * animationValue,
                          Color(0xffFFB547),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Status Badge and Points
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 9),
                decoration: BoxDecoration(
                  color: Color(0xff51CF66).withOpacity(0.1),
                  border: Border.all(
                    color: Color(0xff51CF66).withOpacity(0.3),
                    width: 1.18,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "Excellent",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2F9E44),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.trending_up_outlined,
                color: Color(0xff51CF66),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                "+3 pts this week",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff51CF66),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff343A40),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Color(0xffE9ECEF),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Background circle
    final backgroundPaint = Paint()
      ..color = Color(0xffE9ECEF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = Color(0xff51CF66)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

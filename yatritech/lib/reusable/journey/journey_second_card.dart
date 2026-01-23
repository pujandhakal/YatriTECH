import 'package:flutter/material.dart';

class JourneySecondCard extends StatefulWidget {
  final String startingPoint;
  final String endingPoint;
  final double distance;
  final int minutes;
  final int speed;
  final int noOfTurns;
  final int noOfStops;
  final String date;
  final bool isModerate;
  const JourneySecondCard({
    super.key,
    required this.startingPoint,
    required this.endingPoint,
    required this.distance,
    required this.minutes,
    required this.speed,
    required this.noOfTurns,
    required this.noOfStops,
    required this.date,
    required this.isModerate,
  });

  @override
  State<JourneySecondCard> createState() => _JourneySecondCardState();
}

class _JourneySecondCardState extends State<JourneySecondCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            spreadRadius: -8,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            spreadRadius: -4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Map Section with Badge
          Container(
            height: 128,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFEDF2F7), Color(0xFFE9ECEF)],
              ),
            ),
            child: Stack(
              children: [
                // Simplified map representation
                Positioned.fill(
                  child: CustomPaint(painter: _RouteMapPainter()),
                ),
                // Moderate Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: widget.isModerate
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB547).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFFFFB547).withOpacity(0.3),
                              width: 1.18,
                            ),
                            borderRadius: BorderRadius.circular(39602500),
                          ),
                          child: const Text(
                            'Moderate',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE67700),
                              height: 1.33,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F9E44).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFFB3E4C0).withOpacity(0.3),
                              width: 1.18,
                            ),
                            borderRadius: BorderRadius.circular(39602500),
                          ),
                          child: const Text(
                            'Simple',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F9E44),
                              height: 1.33,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          // Journey Details Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Route with Start/End Points
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Route Line Indicator
                    Column(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF51CF66),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 24,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF4DA8DA), Color(0xFFFF6B6B)],
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B6B),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Route Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.startingPoint,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF343A40),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.endingPoint,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6C757D),
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Trip Stats
                          Row(
                            children: [
                              _buildStatBadge(
                                Icons.place,
                                '${widget.distance} km',
                              ),
                              const SizedBox(width: 16),
                              _buildStatBadge(
                                Icons.access_time,
                                '${widget.minutes} min',
                              ),
                              const SizedBox(width: 16),
                              _buildStatBadge(
                                Icons.speed,
                                '${widget.speed} km/h',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Additional Info
                          Container(
                            padding: const EdgeInsets.only(top: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xFFE9ECEF),
                                  width: 1.18,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildInfoBadge(
                                  Icons.turn_right,
                                  '${widget.noOfTurns} turns',
                                ),
                                const SizedBox(width: 16),
                                _buildInfoBadge(
                                  Icons.pause_outlined,
                                  '${widget.noOfStops} stops',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Timestamp
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFE9ECEF), width: 1.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Color(0xFF6C757D),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C757D),
                          height: 1.43,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF495057)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF495057),
            height: 1.43,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6C757D)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6C757D),
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

// Custom painter for the route map visualization
class _RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4DA8DA).withOpacity(0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw a curved path representing the route
    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width * 0.7,
      size.height * 0.2,
    );

    canvas.drawPath(path, paint);

    // Draw start point (green)
    final startPaint = Paint()
      ..color = const Color(0xFF51CF66)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      4,
      startPaint,
    );

    // Draw end point (red)
    final endPaint = Paint()
      ..color = const Color(0xFFFF6B6B)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), 4, endPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

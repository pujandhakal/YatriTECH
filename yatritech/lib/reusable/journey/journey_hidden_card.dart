import 'package:flutter/material.dart';

class JourneyHiddenCard extends StatefulWidget {
  const JourneyHiddenCard({super.key});

  @override
  State<JourneyHiddenCard> createState() => _JourneyHiddenCardState();
}

class _JourneyHiddenCardState extends State<JourneyHiddenCard> {
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
      padding: EdgeInsets.all(21.171),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Frequently Used Routes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff343A40),
              height: 1.5,
            ),
          ),
          SizedBox(height: 15.989),
          Container(
            height: 191.993,
            decoration: BoxDecoration(
              color: Color(0xFFEDF2F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Map visualization placeholder
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomPaint(painter: RouteMapPainter()),
                  ),
                ),
                // Legend at bottom right
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFE9ECEF), width: 1.18),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 13.167,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLegendItem(Color(0xFFFF6B6B), "High"),
                        SizedBox(width: 11.987),
                        _buildLegendItem(Color(0xFFFFB547), "Med"),
                        SizedBox(width: 11.987),
                        _buildLegendItem(Color(0xff51CF66), "Low"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 11.987,
          height: 11.987,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(39602500),
          ),
        ),
        SizedBox(width: 5.993),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xff6C757D),
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

class RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw route lines with gradients
    final paint1 = Paint()
      ..color = Color(0xff51CF66).withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paint2 = Paint()
      ..color = Color(0xFFFF6B6B).withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paint3 = Paint()
      ..color = Color(0xFFFFB547).withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw curved route lines
    // Green route (top)
    final path1 = Path();
    path1.moveTo(size.width * 0.1, size.height * 0.5);
    path1.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.2,
      size.width * 0.9,
      size.height * 0.4,
    );
    canvas.drawPath(path1, paint1);

    // Red route (middle)
    final path2 = Path();
    path2.moveTo(size.width * 0.1, size.height * 0.65);
    path2.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.5,
      size.width * 0.9,
      size.height * 0.6,
    );
    canvas.drawPath(path2, paint2);

    // Orange route (bottom)
    final path3 = Path();
    path3.moveTo(size.width * 0.1, size.height * 0.8);
    path3.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.65,
      size.width * 1,
      size.height * 0.68,
    );
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

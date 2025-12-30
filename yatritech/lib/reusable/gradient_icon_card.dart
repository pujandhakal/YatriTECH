import 'package:flutter/material.dart';

class GradientIconCard extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;
  final double size;
  final Color iconColor;

  const GradientIconCard({
    super.key,
    required this.icon,
    this.gradientColors = const [
      Color(0xFF155DFC),
      Color(0xFF2B7FFF),
      Color(0xff4F39F6),
    ],
    this.size = 64.0,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 20),
            spreadRadius: -5,
          ),
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 8),
            spreadRadius: -6,
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, size: size * 0.5, color: iconColor),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class QuickActionCard extends StatefulWidget {
  final IconData iconName;
  final String actionName;
  final List<Color> gradientColor;

  const QuickActionCard({
    super.key,
    required this.iconName,
    required this.actionName,
    required this.gradientColor,
  });

  @override
  State<QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<QuickActionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, right: 16),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        children: [
          GradientIconCard(
            icon: widget.iconName,
            gradientColors: widget.gradientColor,
          ),
          SizedBox(height: 10),
          Text(
            widget.actionName,
            style: TextStyle(fontSize: 12, color: Color(0xff364153)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnalyticsFifthCard extends StatefulWidget {
  const AnalyticsFifthCard({super.key});

  @override
  State<AnalyticsFifthCard> createState() => _AnalyticsFifthCardState();
}

class _AnalyticsFifthCardState extends State<AnalyticsFifthCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Insights",
          style: TextStyle(fontSize: 16, color: Color(0xff343A40)),
        ),
        SizedBox(height: 16),
        _buildInsightCard(
          "Safe Driver Streak",
          "12 days",
          Icons.workspace_premium,
          Color(0xff51CF66),
          hasArrow: true,
        ),
        SizedBox(height: 12),
        _buildInsightCard(
          "Avg Speed",
          "42 km/h",
          Icons.speed,
          Color(0xffFFB547),
          hasArrow: false,
        ),
        SizedBox(height: 12),
        _buildInsightCard(
          "Total Trips",
          "28 trips",
          Icons.calendar_month,
          Color(0xff4DA8DA),
          hasArrow: true,
        ),
      ],
    );
  }

  Widget _buildInsightCard(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool hasArrow = false,
  }) {
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
      padding: EdgeInsets.all(17),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff343A40),
                  ),
                ),
              ],
            ),
          ),
          if (hasArrow)
            Icon(Icons.trending_up, color: Color(0xff51CF66), size: 20),
        ],
      ),
    );
  }
}

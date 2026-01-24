import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class AnalyticsSecondCard extends StatefulWidget {
  const AnalyticsSecondCard({super.key});

  @override
  State<AnalyticsSecondCard> createState() => _AnalyticsSecondCardState();
}

class _AnalyticsSecondCardState extends State<AnalyticsSecondCard> {
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
                      color: Color(0xff4DA8DA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: Color(0xff4DA8DA),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Distance",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6C757D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "133.0 km",
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

          // Chart
          SizedBox(
            height: 96,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 35),
                      FlSpot(1, 45),
                      FlSpot(2, 40),
                      FlSpot(3, 55),
                      FlSpot(4, 50),
                      FlSpot(5, 65),
                      FlSpot(6, 60),
                    ],
                    isCurved: true,
                    color: Color(0xff4DA8DA),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Color(0xff4DA8DA),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Color(0xff4DA8DA).withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Stats Cards
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Color(0xffE9ECEF).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Daily Average",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "19.0 km",
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
                                      color: Color(0xffE9ECEF).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Longest Trip",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "24.3 km",
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

                            // Daily Breakdown
                            Text(
                              "Daily Breakdown",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff343A40),
                              ),
                            ),
                            SizedBox(height: 12),
                            _buildDayBar("Mon", 12.4, 0.51),
                            SizedBox(height: 8),
                            _buildDayBar("Tue", 18.2, 0.75),
                            SizedBox(height: 8),
                            _buildDayBar("Wed", 15.7, 0.65),
                            SizedBox(height: 8),
                            _buildDayBar("Thu", 22.1, 0.91),
                            SizedBox(height: 8),
                            _buildDayBar("Fri", 19.8, 0.81),
                            SizedBox(height: 8),
                            _buildDayBar("Sat", 24.3, 1.0),
                            SizedBox(height: 8),
                            _buildDayBar("Sun", 20.5, 0.84),
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

  Widget _buildDayBar(String day, double distance, double progress) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          child: Text(
            day,
            style: TextStyle(fontSize: 14, color: Color(0xff6C757D)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xffE9ECEF),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff4DA8DA), Color(0xff73C2FB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    "${distance.toStringAsFixed(1)} km",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

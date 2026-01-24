import 'package:flutter/material.dart';
import 'package:yatritech/reusable/analytics/analytics_fifth_card.dart';
import 'package:yatritech/reusable/analytics/analytics_first_card.dart';
import 'package:yatritech/reusable/analytics/analytics_fourth_card.dart';
import 'package:yatritech/reusable/analytics/analytics_second_card.dart';
import 'package:yatritech/reusable/analytics/analytics_third_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedTab = "This Week";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/car.png"),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Analytics & Insights",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff343A40),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Track your driving behavior and performance",
                style: TextStyle(fontSize: 16, color: Color(0xff6C757D)),
              ),
              SizedBox(height: 32),

              _buildTabButtons(),
              SizedBox(height: 24),
              AnalyticsFirstCard(),
              SizedBox(height: 24),
              AnalyticsSecondCard(),
              SizedBox(height: 24),
              AnalyticsThirdCard(),
              SizedBox(height: 24),
              AnalyticsFourthCard(),
              SizedBox(height: 24),
              AnalyticsFifthCard(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildTabButton("This Week", _selectedTab == "This Week"),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildTabButton("This Month", _selectedTab == "This Month"),
        ),
      ],
    );
  }

  Widget _buildTabButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = label;
        });
      },
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xff4DA8DA)
              : Color(0xffFFFFFF).withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? null
              : Border.all(
                  color: Color(0xffFFFFFF).withOpacity(0.4),
                  width: 1.18,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Color(0xff6C757D),
            ),
          ),
        ),
      ),
    );
  }
}

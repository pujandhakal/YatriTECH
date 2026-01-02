import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class TodayImpactInner extends StatefulWidget {
  final String innerName;
  final String innerFirstValue;
  final String innerSecondValue;
  final double progressPercent;
  final List<Color> progressGradient;
  final IconData iconName;

  const TodayImpactInner({
    super.key,
    required this.innerName,
    required this.progressPercent,
    required this.progressGradient,
    required this.iconName,
    required this.innerFirstValue,
    required this.innerSecondValue,
  });

  @override
  State<TodayImpactInner> createState() => _TodayImpactInnerState();
}

class _TodayImpactInnerState extends State<TodayImpactInner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          GradientIconCard(
            icon: widget.iconName,
            size: 48,
            gradientColors: widget.progressGradient,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      widget.innerName,
                      style: TextStyle(color: Color(0xff4A5565)),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.innerFirstValue,
                          style: TextStyle(
                            fontSize: 20,
                            color: widget.progressGradient[0],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.innerSecondValue,
                          style: TextStyle(color: widget.progressGradient[0]),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: LinearPercentIndicator(
                    lineHeight: 8,
                    percent: widget.progressPercent,
                    padding: EdgeInsets.zero,
                    barRadius: Radius.circular(16),
                    backgroundColor: Color(0xffF3F4F6),
                    // progressColor: Colors.blue,
                    linearGradient: LinearGradient(
                      colors: widget.progressGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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
}

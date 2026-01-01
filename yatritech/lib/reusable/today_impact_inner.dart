import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class TodayImpactInner extends StatefulWidget {
  const TodayImpactInner({super.key});

  @override
  State<TodayImpactInner> createState() => _TodayImpactInnerState();
}

class _TodayImpactInnerState extends State<TodayImpactInner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          GradientIconCard(icon: Icons.schedule_outlined, size: 48),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Saved",
                    style: TextStyle(color: Color(0xff4A5565)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "23 ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff155DFC),
                        ),
                      ),
                      Text("min", style: TextStyle(color: Color(0xff155DFC))),
                    ],
                  ),
                ],
              ),
              LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: 0.5,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

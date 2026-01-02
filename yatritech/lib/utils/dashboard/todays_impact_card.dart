import 'package:flutter/material.dart';
import 'package:yatritech/reusable/today_impact_inner.dart';

class TodaysImpactCard extends StatefulWidget {
  const TodaysImpactCard({super.key});

  @override
  State<TodaysImpactCard> createState() => _TodaysImpactCardState();
}

class _TodaysImpactCardState extends State<TodaysImpactCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Impact",
                style: TextStyle(fontSize: 16, color: Color(0xff101828)),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xffF0FDF4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.stacked_line_chart,
                      color: Color(0xff00A63E),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "+12%",
                      style: TextStyle(color: Color(0xff00A63E), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          Column(
            children: [
              TodayImpactInner(
                innerName: "Time Saved",
                progressPercent: 0.7,
                progressGradient: [Color(0xff2B7FFF), Color(0xff4F39F6)],
                iconName: Icons.schedule_outlined,
                innerFirstValue: "23",
                innerSecondValue: "min",
              ),
              TodayImpactInner(
                innerName: "Fuel Saved",
                progressPercent: 0.4,
                progressGradient: [Color(0xff00C950), Color(0xff009966)],
                iconName: Icons.local_gas_station_outlined,
                innerFirstValue: "0.8",
                innerSecondValue: "L",
              ),
              TodayImpactInner(
                innerName: "CO₂ Reduced",
                progressPercent: 0.6,
                progressGradient: [Color(0xff00BC7D), Color(0xff009689)],
                iconName: Icons.energy_savings_leaf_outlined,
                innerFirstValue: "1.2",
                innerSecondValue: "kg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

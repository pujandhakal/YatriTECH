import 'package:flutter/material.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';
import 'package:yatritech/utils/dashboard/quick_action_card.dart';
import 'package:yatritech/utils/dashboard/todays_impact_card.dart';
import 'package:yatritech/utils/dashboard/vehical_status_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            GradientIconCard(icon: Icons.bolt_outlined, size: 44),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("YatriTECH", style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Vehicle Online",
                      style: TextStyle(fontSize: 12, color: Color(0xff6A7282)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_outlined,
                size: 28,
                color: Color(0xff364153),
              ),
              Positioned(
                top: -3,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
              ),
            ],
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
              VehicalStatusCard(),
              Text(
                "Quick Actions",
                style: TextStyle(fontSize: 16, color: Color(0xff101828)),
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuickActionCard(
                    iconName: Icons.lock_outline,
                    actionName: "Emergency SOS",
                    gradientColor: [Color(0xff2B7FFF), Color(0xff4F39F6)],
                  ),
                  QuickActionCard(
                    iconName: Icons.location_on_outlined,
                    actionName: "Live Location",
                    gradientColor: [Color(0xff00C950), Color(0xff009966)],
                  ),
                  QuickActionCard(
                    iconName: Icons.security_outlined,
                    actionName: "Theft Mode",
                    gradientColor: [Color(0xffFB2C36), Color(0xffEC003F)],
                  ),
                ],
              ),

              TodaysImpactCard(),
            ],
          ),
        ),
      ),
    );
  }
}

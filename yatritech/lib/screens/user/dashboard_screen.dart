import 'package:flutter/material.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

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
        leading: GradientIconCard(icon: Icons.bolt_outlined),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("YatriTECH"),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 8),
                Text("Vehicle Online"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

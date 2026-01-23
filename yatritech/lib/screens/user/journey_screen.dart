import 'package:flutter/material.dart';
import 'package:yatritech/reusable/journey/journey_first_card.dart';
import 'package:yatritech/reusable/journey/journey_second_card.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Journey Memory",
                style: TextStyle(fontSize: 24, color: Color(0xff343A40)),
              ),
              SizedBox(height: 8),
              Text(
                "Your complete travel history and insights",
                style: TextStyle(color: Color(0xff6C757D), fontSize: 16),
              ),
              SizedBox(height: 32),
              JourneyFirstCard(),
              SizedBox(height: 32),
              Text("Recent Trips", style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              JourneySecondCard(
                isModerate: true,
                startingPoint: 'Home',
                endingPoint: 'Office',
                distance: 18.2,
                minutes: 32,
                speed: 34,
                noOfTurns: 12,
                noOfStops: 3,
                date: 'Today, 9:15 AM',
              ),
              SizedBox(height: 16),
              JourneySecondCard(
                isModerate: false,
                startingPoint: 'Office',
                endingPoint: 'City Mall',
                distance: 12.5,
                minutes: 28,
                speed: 27,
                noOfTurns: 8,
                noOfStops: 5,
                date: 'Yesterday, 6:30 PM',
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yatritech/reusable/journey/journey_first_card.dart';
import 'package:yatritech/reusable/journey/journey_hidden_card.dart';
import 'package:yatritech/reusable/journey/journey_second_card.dart';
import 'package:yatritech/screens/user/profile_sidebar_screen.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  bool _showHeatmap = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width,
        child: ProfileSidebarScreen(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 40.9,
            height: 40.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff4DA8DA), Color(0xff73C2FB)],
              ),
              border: Border.all(
                color: Color(0xFFFFFFFF).withOpacity(0.5),
                width: 1.54,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },

                  child: ClipOval(
                    child: Image.network(
                      "https://picsum.photos/240",
                      width: 40.9,
                      height: 40.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff51CF66),
                      border: Border.all(color: Colors.white, width: 1.18),
                    ),
                  ),
                ),
              ],
            ),
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
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff343A40),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Your complete travel history and insights",
                style: TextStyle(color: Color(0xff6C757D), fontSize: 16),
              ),
              SizedBox(height: 32),
              JourneyFirstCard(
                showHeatmap: _showHeatmap,
                onHeatmapToggle: () {
                  setState(() {
                    _showHeatmap = !_showHeatmap;
                  });
                },
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: _showHeatmap
                    ? Column(
                        children: [SizedBox(height: 16), JourneyHiddenCard()],
                      )
                    : SizedBox.shrink(),
              ),
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

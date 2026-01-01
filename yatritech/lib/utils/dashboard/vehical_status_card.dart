import 'package:flutter/material.dart';

class VehicalStatusCard extends StatefulWidget {
  const VehicalStatusCard({super.key});

  @override
  State<VehicalStatusCard> createState() => _VehicalStatusCardState();
}

class _VehicalStatusCardState extends State<VehicalStatusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [Color(0xff155DFC), Color(0xff2B7FFF), Color(0xff4F39F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 24, right: 24, bottom: 16),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xffFEF2F2),
                  borderRadius: BorderRadius.circular(16),
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
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Heavy Traffic",
                      style: TextStyle(color: Color(0xffC10007)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(28),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      offset: Offset(0, 25),
                      blurRadius: 50,
                      spreadRadius: -12,
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xff629CFE),
                  border: Border.all(color: Color(0xffA3C7FF), width: 5),
                ),
                child: Icon(
                  Icons.directions_car_outlined,
                  color: Colors.white,
                  size: 80,
                ),
              ),

              Positioned(
                bottom: 35,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Current Status",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),

          SizedBox(height: 4),
          Text("Parked", style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 4),
          Text(
            "Traffic is congested Ahead.",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

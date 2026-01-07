import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          Positioned(
            top: 36,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(60, 0, 0, 0),
                    offset: Offset(0, 25),
                    blurRadius: 50,
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GradientIconCard(icon: Icons.search, size: 40),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search destination",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff99A1AF),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffF3F4F6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.mic_outlined,
                          color: Color(0xff4A5565),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),

          Positioned(
            top: 382,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 20),
                        blurRadius: 25,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        spreadRadius: -6,
                      ),
                    ],
                  ),
                  child: Icon(Icons.my_location_outlined),
                ),
                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 20),
                        blurRadius: 25,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        spreadRadius: -6,
                      ),
                    ],
                  ),
                  child: Icon(Icons.layers_outlined),
                ),

                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 20),
                        blurRadius: 25,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(60, 0, 0, 0),
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        spreadRadius: -6,
                      ),
                    ],
                  ),
                  child: Transform.rotate(
                    angle: 90,
                    child: Icon(Icons.brightness_2_outlined),
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

import 'dart:async';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatritech/common/location_manager.dart';
import 'package:yatritech/common/service_call.dart';
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

  late LatLng currentPosition;
  Set<Marker> markers = Set();

  BitmapDescriptor? icon;

  @override
  void initState() {
    super.initState();

    getIcon();

    currentPosition = LatLng(
      LocationManager.shared.currentPos?.latitude ?? 0.0,
      LocationManager.shared.currentPos?.longitude ?? 0.0,
    );

    addMarker();

    FBroadcast.instance().register("update_location", (newLocation, callback) {
      if (newLocation is Position) {
        var mid = MarkerId(ServiceCall.userUUID);
        var newPosition = LatLng(newLocation.latitude, newLocation.longitude);
        markers = {
          Marker(
            markerId: mid,
            position: newPosition,
            icon: icon ?? BitmapDescriptor.defaultMarker,
            rotation: LocationManager.calculateDegree(
              currentPosition,
              newPosition,
            ),
            anchor: const Offset(0.5, 0.5),
          ),
        };
        currentPosition = newPosition;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text("To the lake!"),
        icon: Icon(Icons.directions_boat),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition, zoom: 16),
      ),
    );
  }

  void addMarker() {
    var mid = MarkerId(ServiceCall.userUUID);
    markers.add(
      Marker(
        markerId: mid,
        position: currentPosition,
        icon: icon ?? BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {});
  }

  getIcon() async {
    var icon = await BitmapDescriptor.asset(
      const ImageConfiguration(devicePixelRatio: 3.2),
      "assets/car.png",
      width: 40,
      height: 40,
    );

    setState(() {
      this.icon = icon;
    });
  }
}

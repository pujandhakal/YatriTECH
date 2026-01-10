import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  static final LocationManager sigleton = LocationManager._internal();

  LocationManager._internal();

  static LocationManager get shared => sigleton;

  Position? currentPos;

  void initLocation() {
    getLocationUpdate();
  }

  getLocationUpdate() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      debugPrint("Location service are disabled");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location service are denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location service are permanently denied, we cannot request permission",
      );
      return;
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 15,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            currentPos = position;

            
            debugPrint(position.toString());
          },
        );
  }
}

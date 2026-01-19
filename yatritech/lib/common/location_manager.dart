import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatritech/common/globs.dart';
import 'package:yatritech/common/service_call.dart';
import 'package:yatritech/common/socket_manager.dart';

class LocationManager {
  static final LocationManager sigleton = LocationManager._internal();

  LocationManager._internal();

  static LocationManager get shared => sigleton;

  Position? currentPos;
  double carDegree = 0.0;

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
            carDegree = calculateDegree(
              LatLng(currentPos?.latitude ?? 0.0, currentPos?.longitude ?? 0.0),
              LatLng(position.latitude, position.longitude),
            );

            currentPos = position;
            apiCarUpdateLocation();

            FBroadcast.instance().broadcast("update_location", value: position);
            debugPrint(position.toString());
          },
        );
  }

  static double calculateDegree(LatLng startPoint, LatLng endPoint) {
    final double startLat = toRadians(startPoint.latitude);
    final double startLng = toRadians(startPoint.longitude);

    final double endLat = toRadians(endPoint.latitude);
    final double endLng = toRadians(endPoint.longitude);

    final double deltaLng = endLng - startLng;

    final double y = math.sin(deltaLng) * math.cos(endLat);
    final double x =
        math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(deltaLng);

    final double bearing = math.atan2(y, x);

    return (toDegrees(bearing) + 360) % 360;
  }

  static double toRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  static double toDegrees(double radians) {
    return radians * (180.0 / math.pi);
  }

  //TODO: Api Calling

  void apiCarUpdateLocation() {
    ServiceCall.post(
      {
        "uuid": ServiceCall.userUUID,
        "lat": (currentPos?.latitude ?? 0.0).toString(),
        "lng": (currentPos?.longitude ?? 0.0).toString(),
        "degree": carDegree.toString(),
        "socket_id": SocketManager.shared.socket?.id ?? "",
      },
      SVKey.svCarUpdateLocation,
      (responseObj) async {
        if (responseObj[KKey.status] == "1") {
          debugPrint(responseObj[KKey.message] as String? ?? MSG.success);
        } else {
          debugPrint(responseObj[KKey.message] as String? ?? MSG.fail);
        }
      },
      (error) async {
        debugPrint(error.toString());
      },
    );
  }
}

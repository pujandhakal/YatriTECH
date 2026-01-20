import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatritech/common/globs.dart';
import 'package:yatritech/common/location_manager.dart';
import 'package:yatritech/common/service_call.dart';
import 'package:yatritech/common/socket_manager.dart';
import 'package:yatritech/common/telemetry_service.dart';
import 'package:yatritech/common/models/vehicle_location.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Kathmandu Valley center coordinates
  static const CameraPosition _kathmanduValley = CameraPosition(
    target: LatLng(27.7172, 85.3240), // Kathmandu center
    zoom: 13.0,
  );

  late LatLng currentPosition;
  Map<String, Marker> usersCarArr = {};
  BitmapDescriptor? icon;

  // Simulation
  bool simulationEnabled = true;
  List<CarSimulator> simulatedCars = [];
  Timer? simulationTimer;

  // Python server data
  bool pythonServerEnabled = true;
  Timer? pythonDataTimer;
  List<VehicleLocation> liveVehicles = [];

  @override
  void initState() {
    super.initState();

    getIcon();

    currentPosition = LatLng(
      LocationManager.shared.currentPos?.latitude ?? 27.7172,
      LocationManager.shared.currentPos?.longitude ?? 85.3240,
    );

    // Socket listeners
    SocketManager.shared.socket?.on(SVKey.nvCarJoin, (data) {
      if (data[KKey.status] == "1") {
        updateOtherCarLocation(data[KKey.payload] as Map? ?? {});
      }
    });

    SocketManager.shared.socket?.on(SVKey.nvCarUpdateLocation, (data) {
      if (data[KKey.status] == "1") {
        updateOtherCarLocation(data[KKey.payload] as Map? ?? {});
      }
    });

    apiCarJoin();

    // Initialize simulated cars
    if (simulationEnabled) {
      initializeSimulatedCars();
      startSimulation();
    }

    // Start fetching live data from Python server
    if (pythonServerEnabled) {
      fetchLiveVehicleData();
      startPythonDataFetching();
    }
  }

  void initializeSimulatedCars() {
    // Create 6 cars with different starting positions and routes in Kathmandu Valley
    simulatedCars = [
      // Car 1: Around Thamel area
      CarSimulator(
        id: 'sim_car_1',
        startLat: 27.7155,
        startLng: 85.3132,
        routeType: RouteType.circular,
        speed: 0.0001,
      ),
      // Car 2: Around Patan area
      CarSimulator(
        id: 'sim_car_2',
        startLat: 27.6710,
        startLng: 85.3250,
        routeType: RouteType.horizontal,
        speed: 0.00015,
      ),
      // Car 3: Around Bhaktapur area
      CarSimulator(
        id: 'sim_car_3',
        startLat: 27.6710,
        startLng: 85.4298,
        routeType: RouteType.vertical,
        speed: 0.00012,
      ),
      // Car 4: Around New Baneshwor
      CarSimulator(
        id: 'sim_car_4',
        startLat: 27.6954,
        startLng: 85.3448,
        routeType: RouteType.diagonal,
        speed: 0.00018,
      ),
      // Car 5: Around Balaju area
      CarSimulator(
        id: 'sim_car_5',
        startLat: 27.7330,
        startLng: 85.3010,
        routeType: RouteType.circular,
        speed: 0.00013,
      ),
      // Car 6: Around Koteshwor area
      CarSimulator(
        id: 'sim_car_6',
        startLat: 27.6780,
        startLng: 85.3480,
        routeType: RouteType.zigzag,
        speed: 0.00016,
      ),
    ];
  }

  void startSimulation() {
    simulationTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      for (var car in simulatedCars) {
        car.move();
        updateSimulatedCarMarker(car);
      }
    });
  }

  void updateSimulatedCarMarker(CarSimulator car) {
    usersCarArr[car.id] = Marker(
      markerId: MarkerId(car.id),
      position: LatLng(car.currentLat, car.currentLng),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      rotation: car.bearing,
      anchor: const Offset(0.5, 0.5),
      infoWindow: InfoWindow(
        title: 'Car ${car.id.split('_').last}',
        snippet: 'Simulated',
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    simulationTimer?.cancel();
    pythonDataTimer?.cancel();
    SocketManager.shared.socket?.off(SVKey.nvCarJoin);
    SocketManager.shared.socket?.off(SVKey.nvCarUpdateLocation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'toggle_python',
            onPressed: togglePythonServer,
            backgroundColor: pythonServerEnabled
                ? Color(0xff10B981)
                : Color(0xffEF4444),
            child: Icon(
              pythonServerEnabled ? Icons.cloud : Icons.cloud_off,
              color: Colors.white,
            ),
            mini: true,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'toggle_sim',
            onPressed: toggleSimulation,
            backgroundColor: Color(0xff3370FD),
            child: Icon(
              simulationEnabled ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            mini: true,
          ),
          // SizedBox(height: 10),
          // FloatingActionButton.extended(
          //   heroTag: 'center',
          //   onPressed: _goToKathmandu,
          //   label: Text("Center View"),
          //   icon: Icon(Icons.my_location),
          // ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kathmanduValley,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: usersCarArr.values.toSet(),
            zoomControlsEnabled: false,
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

          // Car counter
          Positioned(
            top: 140,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(60, 0, 0, 0),
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.directions_car, color: Colors.blue),
                  SizedBox(height: 4),
                  Text(
                    '${usersCarArr.length}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'cars',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  if (liveVehicles.isNotEmpty) ...[
                    Divider(height: 8),
                    Row(
                      children: [
                        Icon(Icons.cloud, size: 12, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          '${liveVehicles.length}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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

  void toggleSimulation() {
    setState(() {
      simulationEnabled = !simulationEnabled;
    });

    if (simulationEnabled) {
      startSimulation();
    } else {
      simulationTimer?.cancel();
    }
  }

  void togglePythonServer() {
    setState(() {
      pythonServerEnabled = !pythonServerEnabled;
    });

    if (pythonServerEnabled) {
      fetchLiveVehicleData();
      startPythonDataFetching();
    } else {
      pythonDataTimer?.cancel();
      // Remove Python server markers
      usersCarArr.removeWhere((key, value) => key.startsWith('python_'));
      liveVehicles.clear();
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Start periodic fetching of data from Python server
  void startPythonDataFetching() {
    pythonDataTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchLiveVehicleData();
    });
  }

  /// Fetch live vehicle locations from Python Django server
  Future<void> fetchLiveVehicleData() async {
    if (!pythonServerEnabled) return;

    try {
      final locations = await TelemetryService.getLiveLocations();

      if (locations.isNotEmpty) {
        liveVehicles = locations;

        // Update markers for each vehicle
        for (var vehicle in locations) {
          updatePythonVehicleMarker(vehicle);
        }

        if (mounted) {
          setState(() {});
        }

        debugPrint(
          'Fetched ${locations.length} live vehicles from Python server',
        );
      } else {
        debugPrint('No live vehicles found from Python server');
      }
    } catch (e) {
      debugPrint('Error fetching Python server data: $e');
    }
  }

  /// Update marker for a vehicle from Python server
  void updatePythonVehicleMarker(VehicleLocation vehicle) {
    final markerId = 'python_${vehicle.deviceId}';

    usersCarArr[markerId] = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(vehicle.latitude, vehicle.longitude),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      rotation: vehicle.heading ?? 0.0,
      anchor: const Offset(0.5, 0.5),
      infoWindow: InfoWindow(
        title: vehicle.vehicleId ?? 'Vehicle ${vehicle.deviceId}',
        snippet:
            'Speed: ${vehicle.speed?.toStringAsFixed(1) ?? 'N/A'} m/s\n'
            'Engine: ${vehicle.engineStatus == true ? 'ON' : 'OFF'}',
      ),
    );
  }

  Future<void> _goToKathmandu() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_kathmanduValley),
    );
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

  void updateOtherCarLocation(Map obj) {
    usersCarArr[obj["uuid"].toString()] = Marker(
      markerId: MarkerId(obj["uuid"].toString()),
      position: LatLng(
        double.tryParse(obj["lat"].toString()) ?? 0.0,
        double.tryParse(obj["long"].toString()) ?? 0.0,
      ),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      rotation: double.tryParse(obj["degree"].toString()) ?? 0.0,
      anchor: const Offset(0.5, 0.5),
    );

    if (mounted) {
      setState(() {});
    }
  }

  void apiCarJoin() {
    ServiceCall.post(
      {
        "uuid": ServiceCall.userUUID,
        "lat": currentPosition.latitude.toString(),
        "lng": currentPosition.longitude.toString(),
        "degree": LocationManager.shared.carDegree.toString(),
        "socket_id": SocketManager.shared.socket?.id ?? "",
      },
      SVKey.svCarJoin,
      (responseObj) async {
        if (responseObj[KKey.status] == "1") {
          (responseObj[KKey.payload] as Map? ?? {}).forEach((key, value) {
            usersCarArr[key.toString()] = Marker(
              markerId: MarkerId(key.toString()),
              position: LatLng(
                double.tryParse(value["lat"].toString()) ?? 0.0,
                double.tryParse(value["long"].toString()) ?? 0.0,
              ),
              icon: icon ?? BitmapDescriptor.defaultMarker,
              rotation: double.tryParse(value["degree"].toString()) ?? 0.0,
              anchor: const Offset(0.5, 0.5),
            );
          });

          if (mounted) {
            setState(() {});
          }
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

// Car Simulator Class
enum RouteType { circular, horizontal, vertical, diagonal, zigzag }

class CarSimulator {
  final String id;
  double currentLat;
  double currentLng;
  double bearing = 0.0;
  final RouteType routeType;
  final double speed;
  int tick = 0;

  CarSimulator({
    required this.id,
    required double startLat,
    required double startLng,
    required this.routeType,
    required this.speed,
  }) : currentLat = startLat,
       currentLng = startLng;

  void move() {
    double previousLat = currentLat;
    double previousLng = currentLng;

    tick++;

    switch (routeType) {
      case RouteType.circular:
        // Move in circular pattern
        double angle = tick * 0.1;
        currentLat = currentLat + speed * math.cos(angle);
        currentLng = currentLng + speed * math.sin(angle);
        break;

      case RouteType.horizontal:
        // Move left-right
        currentLng = currentLng + speed * math.sin(tick * 0.05);
        break;

      case RouteType.vertical:
        // Move up-down
        currentLat = currentLat + speed * math.sin(tick * 0.05);
        break;

      case RouteType.diagonal:
        // Move diagonally
        currentLat = currentLat + speed * math.cos(tick * 0.05);
        currentLng = currentLng + speed * math.sin(tick * 0.05);
        break;

      case RouteType.zigzag:
        // Zigzag pattern
        if ((tick ~/ 20) % 2 == 0) {
          currentLng += speed;
        } else {
          currentLng -= speed;
        }
        currentLat += speed * 0.5;
        break;
    }

    // Calculate bearing
    bearing = _calculateBearing(
      previousLat,
      previousLng,
      currentLat,
      currentLng,
    );
  }

  double _calculateBearing(double lat1, double lng1, double lat2, double lng2) {
    double dLng = (lng2 - lng1) * math.pi / 180;
    double lat1Rad = lat1 * math.pi / 180;
    double lat2Rad = lat2 * math.pi / 180;

    double y = math.sin(dLng) * math.cos(lat2Rad);
    double x =
        math.cos(lat1Rad) * math.sin(lat2Rad) -
        math.sin(lat1Rad) * math.cos(lat2Rad) * math.cos(dLng);

    double bearing = math.atan2(y, x);
    return (bearing * 180 / math.pi + 360) % 360;
  }
}

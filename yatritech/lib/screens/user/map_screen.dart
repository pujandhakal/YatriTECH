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
  List<CarSimulator> simulatedCars = [];
  Timer? simulationTimer;

  // Python server data
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

    // Initialize and start simulated cars
    initializeSimulatedCars();
    startSimulation();

    // Start fetching live data from Python server
    fetchLiveVehicleData();
    startPythonDataFetching();
  }

  void initializeSimulatedCars() {
    // Create cars that follow predefined road paths in Kathmandu Valley
    simulatedCars = [
      // Car 1: Ring Road route (North section)
      CarSimulator(
        id: 'sim_car_1',
        roadPath: [
          LatLng(27.7330, 85.3200), // Balaju
          LatLng(27.7350, 85.3300), // Maharajgunj
          LatLng(27.7320, 85.3400), // Bansbari
          LatLng(27.7250, 85.3450), // Jorpati
          LatLng(27.7150, 85.3500), // Koteshwor direction
        ],
        speed: 0.00015,
      ),
      // Car 2: Arniko Highway
      CarSimulator(
        id: 'sim_car_2',
        roadPath: [
          LatLng(27.6850, 85.3450), // Maitighar
          LatLng(27.6900, 85.3550), // Tinkune
          LatLng(27.6850, 85.3650), // Airport area
          LatLng(27.6780, 85.3750), // Jadibuti
          LatLng(27.6710, 85.3950), // Bhaktapur direction
        ],
        speed: 0.00012,
      ),
      // Car 3: Ring Road (South section)
      CarSimulator(
        id: 'sim_car_3',
        roadPath: [
          LatLng(27.6650, 85.3150), // Satdobato
          LatLng(27.6750, 85.3250), // Jawalakhel
          LatLng(27.6850, 85.3300), // Kupondole
          LatLng(27.6900, 85.3350), // Thapathali
          LatLng(27.6950, 85.3400), // Maitighar
        ],
        speed: 0.00018,
      ),
      // Car 4: Prithvi Highway
      CarSimulator(
        id: 'sim_car_4',
        roadPath: [
          LatLng(27.7172, 85.3100), // Thamel
          LatLng(27.7200, 85.3050), // Sorhakhutte
          LatLng(27.7280, 85.2980), // Balaju
          LatLng(27.7350, 85.2900), // Ring Road junction
          LatLng(27.7400, 85.2800), // Kalanki direction
        ],
        speed: 0.00013,
      ),
      // Car 5: East-West through city center
      CarSimulator(
        id: 'sim_car_5',
        roadPath: [
          LatLng(27.7100, 85.3050), // Sorhakhutte
          LatLng(27.7100, 85.3150), // Thamel
          LatLng(27.7100, 85.3240), // Ratna Park
          LatLng(27.7100, 85.3340), // New Road
          LatLng(27.7100, 85.3440), // Koteshwor direction
        ],
        speed: 0.00016,
      ),
      // Car 6: Araniko Highway (reverse)
      CarSimulator(
        id: 'sim_car_6',
        roadPath: [
          LatLng(27.6710, 85.4298), // Bhaktapur
          LatLng(27.6750, 85.4100), // Sallaghari
          LatLng(27.6780, 85.3900), // Jadibuti
          LatLng(27.6850, 85.3700), // Airport
          LatLng(27.6900, 85.3500), // Tinkune
        ],
        speed: 0.00014,
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

  /// Start periodic fetching of data from Python server
  void startPythonDataFetching() {
    pythonDataTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchLiveVehicleData();
    });
  }

  /// Fetch live vehicle locations from Python Django server
  Future<void> fetchLiveVehicleData() async {
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
class CarSimulator {
  final String id;
  final List<LatLng> roadPath;
  final double speed;

  int currentSegment = 0;
  double currentLat;
  double currentLng;
  double bearing = 0.0;
  double progress = 0.0; // Progress along current segment (0.0 to 1.0)

  CarSimulator({required this.id, required this.roadPath, required this.speed})
    : currentLat = roadPath[0].latitude,
      currentLng = roadPath[0].longitude;

  void move() {
    if (roadPath.length < 2) return;

    double previousLat = currentLat;
    double previousLng = currentLng;

    // Get current segment start and end points
    LatLng start = roadPath[currentSegment];
    LatLng end = roadPath[(currentSegment + 1) % roadPath.length];

    // Interpolate between start and end
    progress += speed * 50; // Adjust multiplier for smoother movement

    if (progress >= 1.0) {
      // Move to next segment
      progress = 0.0;
      currentSegment = (currentSegment + 1) % roadPath.length;
      start = roadPath[currentSegment];
      end = roadPath[(currentSegment + 1) % roadPath.length];
    }

    // Linear interpolation
    currentLat = start.latitude + (end.latitude - start.latitude) * progress;
    currentLng = start.longitude + (end.longitude - start.longitude) * progress;

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

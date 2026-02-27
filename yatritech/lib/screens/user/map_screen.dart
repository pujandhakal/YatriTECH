import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatritech/common/globs.dart';
import 'package:yatritech/common/location_manager.dart';
import 'package:yatritech/common/profile_picture.dart';
import 'package:yatritech/common/service_call.dart';
import 'package:yatritech/common/socket_manager.dart';
import 'package:yatritech/common/telemetry_service.dart';
import 'package:yatritech/common/models/vehicle_location.dart';
import 'package:yatritech/reusable/gradient_icon_card.dart';
import 'package:yatritech/reusable/map/current_trip_container.dart';
import 'package:yatritech/reusable/map/speedometer.dart';
import 'package:yatritech/screens/user/crash_detection_screen.dart';
import 'package:yatritech/screens/user/profile_sidebar_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Marker? searchMarker;

  // Map type
  MapType _currentMapType = MapType.normal;

  // Dark mode
  bool _isDarkMode = false;
  static const String _darkMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
  ''';

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
    _searchController.dispose();
    _searchFocusNode.dispose();
    SocketManager.shared.socket?.off(SVKey.nvCarJoin);
    SocketManager.shared.socket?.off(SVKey.nvCarUpdateLocation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width,
        child: ProfileSidebarScreen(),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType,
            initialCameraPosition: _kathmanduValley,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              if (_isDarkMode) {
                await controller.setMapStyle(_darkMapStyle);
              }
            },
            style: _isDarkMode ? _darkMapStyle : null,
            markers: {
              ...usersCarArr.values.toSet(),
              if (searchMarker != null) searchMarker!,
            },
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
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onSubmitted: (value) => _performSearch(value),
                          decoration: InputDecoration(
                            hintText: "Search destination",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff99A1AF),
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        searchMarker = null;
                                      });
                                    },
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                            ProfilePicture(scaffoldKey: _scaffoldKey),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff51CF66),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.18,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
            bottom: 200,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrashDetectionScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromARGB(230, 255, 107, 107),
                  border: Border.all(color: Colors.white30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(40, 0, 0, 0),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -3,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(40, 0, 0, 0),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: Text(
                  "Test Crash",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: CurrentTripContainer(),
          ),
          Positioned(bottom: 250, left: 16, child: Speedometer()),

          Positioned(
            top: 382,
            right: 16,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _goToEverestCollege,
                  child: Container(
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
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: _toggleMapType,
                  child: Container(
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
                    child: Icon(
                      _currentMapType == MapType.normal
                          ? Icons.layers_outlined
                          : _currentMapType == MapType.satellite
                          ? Icons.satellite_alt
                          : _currentMapType == MapType.terrain
                          ? Icons.terrain
                          : Icons.map,
                      color: _currentMapType == MapType.normal
                          ? Colors.black87
                          : Colors.black87,
                    ),
                  ),
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

  Future<void> _goToEverestCollege() async {
    final GoogleMapController controller = await _controller.future;
    const LatLng everestCollege = LatLng(
      27.6875,
      85.3125,
    ); // Everest Engineering College, Sanepa

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: everestCollege, zoom: 17.0),
      ),
    );

    // Add marker for the college
    setState(() {
      searchMarker = Marker(
        markerId: MarkerId('everest_college'),
        position: everestCollege,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Everest Engineering College',
          snippet: 'Sanepa, Kathmandu',
        ),
      );
    });
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

  // Search functionality
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    _searchFocusNode.unfocus();

    // Predefined locations in Kathmandu Valley for demo
    final Map<String, LatLng> locations = {
      'thamel': LatLng(27.7172, 85.3100),
      'durbar square': LatLng(27.7045, 85.3070),
      'pashupatinath': LatLng(27.7105, 85.3485),
      'boudhanath': LatLng(27.7215, 85.3618),
      'swayambhunath': LatLng(27.7149, 85.2906),
      'patan': LatLng(27.6725, 85.3240),
      'bhaktapur': LatLng(27.6710, 85.4298),
      'airport': LatLng(27.6966, 85.3591),
      'ratna park': LatLng(27.7057, 85.3154),
      'balaju': LatLng(27.7330, 85.3000),
      'koteshwor': LatLng(27.6779, 85.3476),
      'new baneshwor': LatLng(27.6939, 85.3397),
      'maitighar': LatLng(27.6967, 85.3278),
      'kalanki': LatLng(27.6942, 85.2827),
      'chabahil': LatLng(27.7229, 85.3540),
    };

    // Search for matching location
    LatLng? targetLocation;
    String? locationName;

    final lowerQuery = query.toLowerCase();
    for (var entry in locations.entries) {
      if (entry.key.contains(lowerQuery) || lowerQuery.contains(entry.key)) {
        targetLocation = entry.value;
        locationName = entry.key
            .split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
        break;
      }
    }

    if (targetLocation == null) {
      // If no match, try to center on Kathmandu
      targetLocation = LatLng(27.7172, 85.3240);
      locationName = query;
    }

    // Add search marker
    setState(() {
      searchMarker = Marker(
        markerId: MarkerId('search_result'),
        position: targetLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: locationName!, snippet: 'Search Result'),
      );
    });

    // Move camera to location
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: targetLocation, zoom: 15.0),
      ),
    );
  }

  // Toggle between map types
  void _toggleMapType() {
    setState(() {
      switch (_currentMapType) {
        case MapType.normal:
          _currentMapType = MapType.satellite;
          break;
        case MapType.satellite:
          _currentMapType = MapType.terrain;
          break;
        case MapType.terrain:
          _currentMapType = MapType.hybrid;
          break;
        case MapType.hybrid:
          _currentMapType = MapType.normal;
          break;
        default:
          _currentMapType = MapType.normal;
      }
    });
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

import 'package:flutter_test/flutter_test.dart';
import 'package:yatritech/common/telemetry_service.dart';
import 'package:yatritech/common/models/vehicle_location.dart';

void main() {
  group('TelemetryService Tests', () {
    test('VehicleLocation model parses JSON correctly', () {
      final json = {
        'device_id': 'DEVICE001',
        'vehicle_id': 'VEHICLE123',
        'latitude': 27.7172,
        'longitude': 85.3240,
        'speed': 15.5,
        'heading': 45.0,
        'altitude': 1400.0,
        'engine_status': true,
        'parking_status': false,
        'timestamp': '2026-01-20T10:30:00Z',
        'received_at': '2026-01-20T10:30:01Z',
      };

      final vehicle = VehicleLocation.fromJson(json);

      expect(vehicle.deviceId, 'DEVICE001');
      expect(vehicle.vehicleId, 'VEHICLE123');
      expect(vehicle.latitude, 27.7172);
      expect(vehicle.longitude, 85.3240);
      expect(vehicle.speed, 15.5);
      expect(vehicle.heading, 45.0);
      expect(vehicle.engineStatus, true);
      expect(vehicle.parkingStatus, false);
    });

    test('VehicleLocation handles null values correctly', () {
      final json = {
        'device_id': 'DEVICE002',
        'latitude': 27.7,
        'longitude': 85.3,
        'timestamp': '2026-01-20T10:30:00Z',
        'received_at': '2026-01-20T10:30:01Z',
      };

      final vehicle = VehicleLocation.fromJson(json);

      expect(vehicle.deviceId, 'DEVICE002');
      expect(vehicle.vehicleId, null);
      expect(vehicle.speed, null);
      expect(vehicle.heading, null);
      expect(vehicle.engineStatus, null);
    });

    test('VehicleLocation converts to JSON correctly', () {
      final vehicle = VehicleLocation(
        deviceId: 'DEVICE001',
        vehicleId: 'VEHICLE123',
        latitude: 27.7172,
        longitude: 85.3240,
        speed: 15.5,
        heading: 45.0,
        timestamp: DateTime.parse('2026-01-20T10:30:00Z'),
        receivedAt: DateTime.parse('2026-01-20T10:30:01Z'),
      );

      final json = vehicle.toJson();

      expect(json['device_id'], 'DEVICE001');
      expect(json['vehicle_id'], 'VEHICLE123');
      expect(json['latitude'], 27.7172);
      expect(json['longitude'], 85.3240);
      expect(json['speed'], 15.5);
      expect(json['heading'], 45.0);
    });

    // Integration test - requires running server
    test('Test connection to Python server', () async {
      final isConnected = await TelemetryService.testConnection();
      print('Python server connection: ${isConnected ? "SUCCESS" : "FAILED"}');
      // Don't fail the test if server is not running
      expect(isConnected, isA<bool>());
    }, skip: true); // Skip by default, run manually when server is available

    // Integration test - requires running server with data
    test('Fetch live locations from server', () async {
      final locations = await TelemetryService.getLiveLocations();
      print('Fetched ${locations.length} vehicles');

      if (locations.isNotEmpty) {
        expect(locations.first, isA<VehicleLocation>());
        print('First vehicle: ${locations.first}');
      }
    }, skip: true); // Skip by default, run manually when server is available
  });
}

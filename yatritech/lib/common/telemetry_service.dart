import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yatritech/common/globs.dart';
import 'package:yatritech/common/models/vehicle_location.dart';

/// Service to interact with Python Django telemetry server
class TelemetryService {
  static const Duration defaultTimeout = Duration(seconds: 10);

  /// Fetch all live vehicle locations from the server
  static Future<List<VehicleLocation>> getLiveLocations() async {
    try {
      final response = await http
          .get(
            Uri.parse(SVKey.svLiveLocations),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(defaultTimeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Handle different response formats
        List<dynamic> locationsData;
        if (data is Map) {
          // If wrapped in status/payload structure
          if (data.containsKey('status') && data.containsKey('payload')) {
            locationsData = data['payload'] as List? ?? [];
          } else if (data.containsKey('results')) {
            locationsData = data['results'] as List? ?? [];
          } else if (data.containsKey('data')) {
            locationsData = data['data'] as List? ?? [];
          } else {
            // Single object response
            locationsData = [data];
          }
        } else if (data is List) {
          locationsData = data;
        } else {
          return [];
        }

        return locationsData
            .map(
              (json) => VehicleLocation.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        debugPrint('Failed to load live locations: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching live locations: $e');
      return [];
    }
  }

  /// Fetch a specific vehicle's location
  static Future<VehicleLocation?> getVehicleLocation(String vehicleId) async {
    try {
      final response = await http
          .get(
            Uri.parse('${SVKey.svVehicleLocation}$vehicleId/'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(defaultTimeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return VehicleLocation.fromJson(data as Map<String, dynamic>);
      } else {
        debugPrint('Failed to load vehicle location: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching vehicle location: $e');
      return null;
    }
  }

  /// Post telemetry data to the server
  static Future<bool> postTelemetry({
    required String deviceId,
    required double latitude,
    required double longitude,
    double? speed,
    double? heading,
    double? altitude,
    bool? engineStatus,
    bool? parkingStatus,
  }) async {
    try {
      final body = {
        'device_id': deviceId,
        'latitude': latitude,
        'longitude': longitude,
        if (speed != null) 'speed': speed,
        if (heading != null) 'heading': heading,
        if (altitude != null) 'altitude': altitude,
        if (engineStatus != null) 'engine_status': engineStatus,
        if (parkingStatus != null) 'parking_status': parkingStatus,
      };

      final response = await http
          .post(
            Uri.parse(SVKey.svPostTelemetry),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(body),
          )
          .timeout(defaultTimeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Telemetry posted successfully');
        return true;
      } else {
        debugPrint('Failed to post telemetry: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error posting telemetry: $e');
      return false;
    }
  }

  /// Test connection to the Python server
  static Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse(SVKey.svLiveLocations))
          .timeout(Duration(seconds: 5));
      return response.statusCode == 200 || response.statusCode == 404;
    } catch (e) {
      debugPrint('Python server connection test failed: $e');
      return false;
    }
  }
}

/// Model for vehicle location data from Python telemetry server
class VehicleLocation {
  final String deviceId;
  final String? vehicleId;
  final double latitude;
  final double longitude;
  final double? speed;
  final double? heading;
  final double? altitude;
  final bool? engineStatus;
  final bool? parkingStatus;
  final DateTime timestamp;
  final DateTime receivedAt;

  VehicleLocation({
    required this.deviceId,
    this.vehicleId,
    required this.latitude,
    required this.longitude,
    this.speed,
    this.heading,
    this.altitude,
    this.engineStatus,
    this.parkingStatus,
    required this.timestamp,
    required this.receivedAt,
  });

  /// Create VehicleLocation from JSON response
  factory VehicleLocation.fromJson(Map<String, dynamic> json) {
    return VehicleLocation(
      deviceId: json['device_id']?.toString() ?? '',
      vehicleId: json['vehicle_id']?.toString(),
      latitude: _parseDouble(json['latitude']) ?? 0.0,
      longitude: _parseDouble(json['longitude']) ?? 0.0,
      speed: _parseDouble(json['speed']),
      heading: _parseDouble(json['heading']),
      altitude: _parseDouble(json['altitude']),
      engineStatus: json['engine_status'] as bool?,
      parkingStatus: json['parking_status'] as bool?,
      timestamp: _parseDateTime(json['timestamp']) ?? DateTime.now(),
      receivedAt: _parseDateTime(json['received_at']) ?? DateTime.now(),
    );
  }

  /// Helper to parse double values
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Helper to parse DateTime values
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'vehicle_id': vehicleId,
      'latitude': latitude,
      'longitude': longitude,
      'speed': speed,
      'heading': heading,
      'altitude': altitude,
      'engine_status': engineStatus,
      'parking_status': parkingStatus,
      'timestamp': timestamp.toIso8601String(),
      'received_at': receivedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'VehicleLocation(deviceId: $deviceId, vehicleId: $vehicleId, lat: $latitude, lng: $longitude, heading: $heading)';
  }
}

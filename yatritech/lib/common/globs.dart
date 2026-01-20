import 'package:yatritech/main.dart';

class Globs {
  static const appName = "YatriTECH";

  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  static String udValueString(String key) {
    return prefs?.getString(key) ?? "";
  }
}

class SVKey {
  static const mainUrl = "http://192.168.1.84:3001";
  static const baseUrl = "$mainUrl/api/";
  static const nodeUrl = mainUrl;

  // Python Django server URLs
  static const pythonServerUrl = "http://192.168.137.1:8000";
  static const pythonApiUrl = "$pythonServerUrl/api/navigate/";

  static const nvCarJoin = "car_join";
  static const nvCarUpdateLocation = "car_update_location";

  static const svCarJoin = "$baseUrl$nvCarJoin";
  static const svCarUpdateLocation = "$baseUrl$nvCarUpdateLocation";

  // Python server endpoints
  static const svLiveLocations = "${pythonApiUrl}live-locations/";
  static const svPostTelemetry = "${pythonApiUrl}telemetry/";
  static const svVehicleLocation =
      "${pythonApiUrl}live-locations/"; // append vehicle_id
}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
}

class MSG {
  static const success = "success";
  static const fail = "fail";
}

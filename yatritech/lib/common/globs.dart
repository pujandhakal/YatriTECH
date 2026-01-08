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
  static const mainUrl = "https://localhost:3001";
  static const baseUrl = "$mainUrl/api/";
  static const nodeUrl = mainUrl;
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

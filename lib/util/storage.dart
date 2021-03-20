import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences prefs;

  static void initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void store(String key, Map<String, dynamic> value) {
    prefs.setString(key, jsonEncode(value));
  }

  static Map<String, dynamic> fetch(String key) {
    String raw = prefs.getString(key);
    
    return raw == null ? null : jsonDecode(raw);
  } 
}

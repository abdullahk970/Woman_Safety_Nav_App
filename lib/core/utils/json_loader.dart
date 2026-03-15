import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  // For JSON LISTS  → [ {...}, {...} ]
  static Future<List<dynamic>> loadList(String path) async {
    final data = await rootBundle.loadString(path);
    return json.decode(data) as List<dynamic>;
  }

  // For JSON OBJECTS → { ... }
  static Future<Map<String, dynamic>> loadObject(String path) async {
    final data = await rootBundle.loadString(path);
    return json.decode(data) as Map<String, dynamic>;
  }
}

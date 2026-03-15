import 'package:flutter/material.dart';

class SafePlaceModel {
  final int id;
  final String name;
  final String type;
  final String distance;
  final String address;
  final double latitude;
  final double longitude;
  double? liveDistance;

  SafePlaceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.liveDistance,
  });

  factory SafePlaceModel.fromJson(Map<String, dynamic> json) {
    return SafePlaceModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      distance: json['distance'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  IconData get icon {
    switch (type) {
      case "Police":
        return Icons.local_police;
      case "Hospital":
        return Icons.local_hospital;
      case "Help Center":
        return Icons.support_agent;
      default:
        return Icons.place;
    }
  }

  Color get color {
    switch (type) {
      case "Police":
        return Colors.blue;
      case "Hospital":
        return Colors.red;
      case "Help Center":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

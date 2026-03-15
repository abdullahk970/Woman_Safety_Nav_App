import 'package:flutter/material.dart';

class HomeFeatureModel {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  HomeFeatureModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  factory HomeFeatureModel.fromJson(Map<String, dynamic> json) {
    return HomeFeatureModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      icon: _mapIcon(json['icon']),
      color: Color(
        int.parse(json['color'].replaceFirst('#', '0xff')),
      ),
    );
  }

  static IconData _mapIcon(String name) {
    switch (name) {
      case 'navigation':
        return Icons.navigation;
      case 'sos':
        return Icons.warning_rounded;
      case 'place':
        return Icons.place;
      case 'person':
        return Icons.person;
      default:
        return Icons.help_outline;
    }
  }
}

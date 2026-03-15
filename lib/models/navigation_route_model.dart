class NavigationRouteModel {
  final int id;
  final String from;
  final String to;
  final String distance;
  final String time;
  final String safetyLevel;

  NavigationRouteModel({
    required this.id,
    required this.from,
    required this.to,
    required this.distance,
    required this.time,
    required this.safetyLevel,
  });

  factory NavigationRouteModel.fromJson(Map<String, dynamic> json) {
    return NavigationRouteModel(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      distance: json['distance'],
      time: json['time'],
      safetyLevel: json['safetyLevel'],
    );
  }
}

class EmergencyContactModel {
  final int id;
  final String name;
  final String phone;

  EmergencyContactModel({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}

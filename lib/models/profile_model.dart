class ProfileModel {
  final String name;
  final String email;
  final String phone;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

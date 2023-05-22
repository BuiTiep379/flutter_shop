import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;

  final String username;
  final String password;
  final String phone;
  final String line;
  final String district;
  final String ward;

  User({
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
    required this.line,
    required this.district,
    required this.ward,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'phone': phone,
      'line': line,
      'district': district,
      'ward': ward,
    };
  }

  User.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : name = snapshot["name"],
        username = snapshot["username"],
        password = snapshot["password"],
        phone = snapshot["phone"],
        line = snapshot["line"],
        district = snapshot["district"],
        ward = snapshot["ward"];

  User.fromMap(Map<String, dynamic> snapshot)
      : name = snapshot["name"],
        username = snapshot["username"],
        password = snapshot["password"],
        phone = snapshot["phone"],
        line = snapshot["line"],
        district = snapshot["district"],
        ward = snapshot["ward"];

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? password,
    String? phone,
    String? line,
    String? district,
    String? ward,
  }) {
    return User(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      line: line ?? this.line,
      district: district ?? this.district,
      ward: ward ?? this.ward,
    );
  }
}

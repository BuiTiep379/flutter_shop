class AccountModel {
  final String id;
  final String fullname;
  final String username;
  final String password;
  final String phone;
  final String line;
  final String district;
  final String ward;
  final String city;

  AccountModel(
      {required this.id,
      required this.fullname,
      required this.username,
      required this.password,
      required this.phone,
      required this.line,
      required this.district,
      required this.ward,
      required this.city});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'password': password,
      'phone': phone,
      'line': line,
      'district': district,
      'ward': ward,
      'city': city,
    };
  }

  AccountModel.fromMap(Map<String, dynamic> productMap)
      : id = productMap["id"],
        fullname = productMap["fullname"],
        username = productMap["username"],
        password = productMap["password"],
        phone = productMap["phone"],
        line = productMap["line"],
        district = productMap["district"],
        ward = productMap["ward"],
        city = productMap["city"];
}

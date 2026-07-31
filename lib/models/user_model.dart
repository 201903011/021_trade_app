import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? "",
      name: map['name']?.toString() ?? "",
      email: map['email']?.toString() ?? "",
      phoneNumber: map['phoneNumber']?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

SignupModel loginModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String loginModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String username;
  String email;
  String? password; // Make optional
  String phone;

  SignupModel(
      {required this.username,
      required this.email,
      this.password, // Make optional
      required this.phone});

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'], // Will be null if not present
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        if (password != null) "password": password,
      };
}

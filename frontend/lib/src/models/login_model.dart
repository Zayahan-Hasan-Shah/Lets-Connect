import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String accessToken;
  String email;
  String? password; // Make optional
  String username;
  String phone;

  LoginModel({
    required this.accessToken,
    required this.email,
    this.password,
    required this.username,
    required this.phone,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["accessToken"] ?? json["token"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        phone: json["phone"] ?? "",
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "email": email,
        "username": username,
        "phone": phone,
        if (password != null) "password": password,
      };
}

import 'dart:convert';

SignupModel loginModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String loginModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String userName;
  String email;
  String password;
  String phoneNumber;

  SignupModel(
      {required this.userName,
      required this.email,
      required this.password,
      required this.phoneNumber});

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber']);

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      };
}

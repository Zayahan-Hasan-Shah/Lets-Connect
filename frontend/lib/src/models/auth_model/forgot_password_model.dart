import 'dart:convert';

ForgotPasswordModel forgootPasswodFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgootPasswodModelToJson(ForgotPasswordModel data) =>
    json.encode(data.toJson());

class ForgotPasswordModel {
  String email;

  ForgotPasswordModel({
    required this.email,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

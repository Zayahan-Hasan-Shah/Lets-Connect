import 'dart:convert';
import 'dart:developer';

import 'package:frontend/src/core/api_urls.dart';
import 'package:frontend/src/models/forgot_password_model.dart';
import 'package:frontend/src/models/login_model.dart';
import 'package:frontend/src/models/signup_model.dart';
import 'package:frontend/src/services/common_services/api_service.dart';

class AuthService {
  Future<SignupModel?> signupService(String userName, String email,
      String password, String phoneNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await APIService.signup(
        api: APIUrls.signupUrl,
        body: {
          "username": userName,
          "email": email,
          "password": password,
          "phone": phoneNumber,
        },
      );
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final responseData = jsonDecode(response.body);

        // Check if response indicates success and has user data
        if (responseData['success'] == true && responseData['user'] != null) {
          return SignupModel.fromJson(
              responseData['user']); // Pass just the user object
        }
      }
      return null;
    } catch (e) {
      log('Error in dummy signup : $e');
      return null;
    }
  }

  Future<LoginModel?> loginService(String email, String password) async {
    try {
      // Simulated delay to mimic a real network call
      await Future.delayed(const Duration(seconds: 1));

      final response = await APIService.login(api: APIUrls.loginUrl, body: {
        "email": email,
        "password": password,
      });

      if (response != null && response.isNotEmpty) {
        final responseData = jsonDecode(response);

        // Check if response indicates success and has user data
        if (responseData['success'] == true &&
            responseData['user'] != null &&
            responseData['token'] != null) {
          // Merge user and token into one map for LoginModel
          final userData = Map<String, dynamic>.from(responseData['user']);
          userData['accessToken'] = responseData['token'];
          return LoginModel.fromJson(userData);
        }
      }

      return null;
    } catch (e) {
      log('Error in login: $e');
      return null;
    }
  }


  Future<ForgotPasswordModel?> forgotPasswordService(String email) async {
    try {
      final response = await APIService.post(
        api: APIUrls.forgotPasswordUrl,
        body: {"email": email},
      );

      if (response != null && response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ForgotPasswordModel.fromJson(responseData);
      }
      return null;
    } catch (e) {
      log('Error in forgot password: $e');
      return null;
    }
  }
}

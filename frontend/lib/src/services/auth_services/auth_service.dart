import 'dart:convert';
import 'dart:developer';

import 'package:frontend/src/core/api_urls.dart';
import 'package:frontend/src/models/login_model.dart';
import 'package:frontend/src/models/signup_model.dart';
import 'package:frontend/src/services/common_services/api_service.dart';

class AuthService {
  Future<SignupModel?> signupService(String userName, String email,
      String password, String phoneNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final res = await APIService.signup(
        api: APIUrls.signupUrl,
        body: {
          "userName": userName,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
        },
      );
      if (res != null) {
        return SignupModel.fromJson(jsonDecode(res));
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

      // Dummy login check
      if (email == 'zayahan@gmail.com' && password == '123qwe') {
        // Return a dummy LoginModel object
        return LoginModel(
          accessToken: 'dummy_token_abc123',
          email: email,
          password: password,
        );
      } else {
        // Invalid credentials
        log('Invalid credentials');
        return null;
      }
    } catch (e) {
      log('Error in dummy login: $e');
      return null;
    }
  }
}

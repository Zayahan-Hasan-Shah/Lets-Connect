import 'dart:developer';

import 'package:frontend/src/models/login_model.dart';
import 'package:frontend/src/models/signup_model.dart';

class AuthService {
  Future<SignupModel?> signupService(String userName, String email,
      String password, String phoneNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (userName == 'Zayahan' &&
          email == 'zayahan@gmail.com' &&
          password == '123qwe' &&
          phoneNumber == '923327699137') {
        return SignupModel(
            userName: userName,
            email: email,
            password: password,
            phoneNumber: phoneNumber);
      } else {
        log('Invalid signup credentials');
        return null;
      }
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

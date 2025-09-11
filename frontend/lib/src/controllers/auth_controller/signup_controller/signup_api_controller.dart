import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/models/auth_model/signup_model.dart';
import 'package:frontend/src/services/auth_services/auth_service.dart';

class SignupAuthNotifier extends StateNotifier<SignupModel?> {
  SignupAuthNotifier() : super(null);

  // Future<SignupModel?> signupAuth(String userName, String email,
  //     String passowrd, String phoneNumber) async {
  //   try {
  //     final response = await AuthService()
  //         .signupService(userName, email, passowrd, phoneNumber);
  //     if (response != null) {
  //       state = response;
  //       return response;
  //     } else {
  //       state = null;
  //     }
  //   } catch (e) {
  //     log('Signup failed : $e');
  //     rethrow;
  //   }
  //   return null;
  // }
  Future<SignupModel?> signupAuth(String userName, String email,
      String password, String phoneNumber) async {
    try {
      final response = await AuthService()
          .signupService(userName, email, password, phoneNumber);
      if (response != null) {
        state = response;
        return response;
      }
      return null;
    } catch (e) {
      log('Signup failed : $e');
      state = null;
      return null;
    }
  }
}

final signupAuthProvider =
    StateNotifierProvider<SignupAuthNotifier, SignupModel?>((ref) {
  return SignupAuthNotifier();
});

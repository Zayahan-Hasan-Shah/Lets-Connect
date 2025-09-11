import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/models/auth_model/login_model.dart';
import 'package:frontend/src/services/auth_services/auth_service.dart';


class LoginAuthNotifier extends StateNotifier<LoginModel?> {
  LoginAuthNotifier() : super(null);

  Future<LoginModel?> loginAuth(String email, String password) async {
    try {
      final response = await AuthService().loginService(email, password);
      if (response != null) {
        state = response;
        return response;
      } else {
        state = null;
      }
    } catch (e) {
      log("Login failed: $e");
      rethrow;
    }
    return null;
  }
}

final loginAuthProvider = StateNotifierProvider<LoginAuthNotifier, LoginModel?>((ref) {
  return LoginAuthNotifier();
});
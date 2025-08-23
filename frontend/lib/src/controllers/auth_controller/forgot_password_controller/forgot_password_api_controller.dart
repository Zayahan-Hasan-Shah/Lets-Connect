import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/models/forgot_password_model.dart';
import 'package:frontend/src/services/auth_services/auth_service.dart';

class ForgotPasswordAuthNotifier extends StateNotifier<ForgotPasswordModel?> {
  ForgotPasswordAuthNotifier() : super(null);

  Future<ForgotPasswordModel?> forgotPasswordAuth(String email) async {
    try {
      final response = await AuthService().forgotPasswordService(email);
      if (response != null) {
        state = response;
        return response;
      } else {
        state = null;
      }
    } catch (e) {
      log("Forgot Password failed: $e");
      rethrow;
    }
    return null;
  }
}

final forgotPasswordAuthNotifier = StateNotifierProvider<ForgotPasswordAuthNotifier, ForgotPasswordModel?>((ref) {
  return ForgotPasswordAuthNotifier();
});
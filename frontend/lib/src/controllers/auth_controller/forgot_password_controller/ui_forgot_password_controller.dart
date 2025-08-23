import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/controllers/auth_controller/forgot_password_controller/forgot_password_state.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState>{
  ForgotPasswordNotifier() : super(ForgotPasswordState(buttonLoader: false, email: ''));

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setForgotPasswordButtonLoaderState(bool? value) {
    state = state.copyWith(buttonLoader: value);
  }

  String get email => state.email;
}

final forgotPasswordNotifierProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) => ForgotPasswordNotifier());
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signup_state.dart';

class SignupNotifier extends StateNotifier<SignupState>{
  SignupNotifier() : super(SignupState(passwordObsecure : true, buttonLoader : false));

  void setPasswordObsercureState (bool? value){
    state = state.copyWith(passwordObsecure: value);
  }

  void setSignupButtonLoaderState(bool? value){
    state = state.copyWith(buttonLoader: value);
  }

  bool get passwordObsecure{
    return state.passwordObsecure;
  }

  bool get buttonLoader {
    return state.buttonLoader;
  }

}

final signupNotifierProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) => SignupNotifier());
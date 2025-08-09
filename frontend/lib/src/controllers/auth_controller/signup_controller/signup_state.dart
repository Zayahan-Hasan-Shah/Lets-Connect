class SignupState {
  SignupState({this.buttonLoader = false, this.passwordObsecure = true});

  final bool buttonLoader;
  final bool passwordObsecure;

  SignupState copyWith({bool? buttonLoader, bool? passwordObsecure}) {
    return SignupState(
      buttonLoader: buttonLoader ?? this.buttonLoader,
      passwordObsecure: passwordObsecure ?? this.passwordObsecure,
    );
  }
}

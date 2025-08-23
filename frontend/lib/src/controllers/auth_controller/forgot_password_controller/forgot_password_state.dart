class ForgotPasswordState {
  final String email;
  final bool buttonLoader;

  ForgotPasswordState({this.email = '', this.buttonLoader = false});

  ForgotPasswordState copyWith({String? email, bool? buttonLoader}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      buttonLoader: buttonLoader ?? this.buttonLoader,
    );
  }
}
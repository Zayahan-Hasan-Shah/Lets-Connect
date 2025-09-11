class APIUrls {
  static const baseUrl = 'http://10.0.2.2:5000'; // android emulator localhost

  static const signupUrl = '$baseUrl/api/v1/auth/signup'; // success
  static const loginUrl = '$baseUrl/api/v1/auth/login'; // success
  static const forgotPasswordUrl = '$baseUrl/api/v1/auth/forgot-password'; // success
  static const changePasswordUrl = '$baseUrl/api/v1/auth/change-password';
  static const getAllPostUrl = '$baseUrl/api/v1/posts/all';
}
class APIUrls {
  static const baseUrl = 'http://localhost:5000';

  static const signupUrl = '$baseUrl/api/v1/auth/signup';
  static const loginUrl = '$baseUrl/api/v1/auth/login';
  static const forgotPasswordUrl = '$baseUrl/api/v1/auth/forgot-password';
  static const changePasswordUrl = '$baseUrl/api/v1/auth/change-password';
}
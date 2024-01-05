abstract class Config {
  /// Example: https://www.example.com without /
  static const String baseUrl = 'https://novel-lamb-smiling.ngrok-free.app';

  /// Will refresh the access token 5 minutes before it expires
  static const int sessionTimeoutThreshold = 0;

  /// if false hide the form login
  /// if false hide the fields password and confirm password from signup form
  /// for security reason and the password generated after verification mail
  static const bool loginWithPassword = true;

  static const bool signupWithPassword = true;
}

class Api {
  static const String baseURL = 'http://10.10.28.57:8005/api';
  // static const String baseURL = 'http://192.168.0.107:8005/api';

  //Auth
  
  static const String login = '$baseURL/login';
  static const String register = '$baseURL/register';
  static const String verifyOtp = '$baseURL/verify/otp';
  static const String me = '$baseURL/profile';
}
class AuthManager {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  String? _token;

  Map<String, dynamic>? _user;

  void saveToken(String token){
    _token = token;
  }

  String? getToken(){
    return _token;
  }

  void saveUser(Map<String, dynamic>user){
    _user = user;
  }

  Map<String, dynamic>? getUser(){
    return _user;
  }

  void clear(){
    _token = null;
    _user = null;
  }

  bool get isLoggedIn => _token != null;
}
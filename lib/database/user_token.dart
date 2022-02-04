import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider {
  static final TokenProvider tokenProvider = TokenProvider();

  String? _token;

  Future<String?> get token async {
    if (_token != null) return _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken') ?? "";
    // log("ini token1: " + _token.toString());
    return _token;
  }
}

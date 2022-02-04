import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static final ApiProvider apiProvider = ApiProvider();

  String? _token;
  String baseUrl = "http://10.0.2.2:3000/api";
  String getFilteredMoviesWithDetail = "/getFilteredMoviesWithDetail";

  Future<Map<String, String>> get requestHeadersWithToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken') ?? "";

    return ({
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': _token!
    });
  }
}

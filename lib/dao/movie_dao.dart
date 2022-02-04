import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flint/database/user_token.dart';
import 'package:http/http.dart' as http;
import 'package:flint/model/movie_details.dart';

class MovieDao {
  final TokenProvider tokenProvider = TokenProvider.tokenProvider;

  Future<List<MovieDetails>> getFilteredMovies() async {
    // void getFilteredMovies() async {
    // void getFilteredMovie() async {
    final token = await tokenProvider.token;
    if (token == null) return [];
    List<Map<String, dynamic>>? result;
    // // String token =
    // //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFmOTNlMjdlODg1NjAxMWIxNWZmMmMwIiwidXNlcm5hbWUiOiJhYmFkaXN1cmlvMyIsImlhdCI6MTY0Mzg1NTAwMiwiZXhwIjoxNjQ0NDU5ODAyfQ.Xw4If_vmGHn79SniiVHmOuo7FdY2ENJT1l3v5oEaHZM';
    String url = 'http://10.0.2.2:3000/api/getFilteredMoviesWithDetail';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var client = http.Client();
    // dev.log(requestHeaders.toString());
    // dev.log("test");
    try {
      final response =
          await client.get(Uri.parse(url), headers: requestHeaders);
      final resultJson = json.decode(response.body);
      result = resultJson['data']['movies'].cast<Map<String, dynamic>>();
      // dev.log(moviesJson[0].toString());
      // return MovieWithDetail.fromJson(jsonDecode(response.body));
    } catch (err) {
      dev.log(err.toString());
    } finally {
      client.close();
    }

    List<MovieDetails> moviesWithDetail = result != null
        ? result.map((e) => MovieDetails.fromJson(e['movie_detail'])).toList()
        : [];

    return moviesWithDetail;
  }
}

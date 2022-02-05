import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flint/database/api_provider.dart';
import 'package:flint/database/user_token.dart';
import 'package:http/http.dart' as http;
import 'package:flint/model/movie_details.dart';

class MovieDao {
  final TokenProvider tokenProvider = TokenProvider.tokenProvider;
  final ApiProvider apiProvider = ApiProvider.apiProvider;

  Future<List<MovieDetails>> getFilteredMovies() async {
    final requestHeaders = await apiProvider.requestHeadersWithToken;
    List<Map<String, dynamic>>? result;
    String baseUrl = apiProvider.baseUrl;
    String endpoint = apiProvider.getFilteredMoviesWithDetail;
    String url = baseUrl + endpoint;
    var client = http.Client();
    try {
      final response =
          await client.get(Uri.parse(url), headers: requestHeaders);
      final resultJson = json.decode(response.body);
      result = resultJson['data']['movies'].cast<Map<String, dynamic>>();
    } catch (err) {
      dev.log(err.toString());
    } finally {
      client.close();
    }

    List<MovieDetails> moviesWithDetail = result != null
        ? result.map((e) {
            // dev.log(e['movie_detail']['title']);
            return MovieDetails.fromJson(e['movie_detail']);
          }).toList()
        : [];

    return moviesWithDetail;
  }
}

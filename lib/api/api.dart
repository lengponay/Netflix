import 'dart:convert';
import 'package:movie_app_2/api/constants.dart';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class Api {
  final upComingApiUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  //TODO: Create popularApiUrl and topRatedApiUrl with refering upComingApiUrl. You can check 'get' in TMDB website and add "?api_key=$apiKey"

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upComingApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  //TODO: Create getPopularMovies(), getTopRatedMovies() with refering getUpcomingMovies()
}

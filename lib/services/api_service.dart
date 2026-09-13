import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "ef0aa44059f4e32bfdfd1fb9fed840b9";
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> getPopularMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_key=$apiKey&page=$page"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  Future<List<dynamic>> getTopRatedMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/top_rated?api_key=$apiKey&page=$page"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  Future<List<dynamic>> getUpcomingMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/upcoming?api_key=$apiKey&page=$page"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to load upcoming movies");
    }
  }

  Future<List<dynamic>> getMoviesByCollection(
    String collection,
    int page,
  ) async {
    switch (collection) {
      case "Popular Movies":
        return await getPopularMovies(page: page);

      case "Top Rated Movies":
        return await getTopRatedMovies(page: page);

      case "Upcoming Movies":
        return await getUpcomingMovies(page: page);

      default:
        throw Exception("Unknown movie collection");
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/$id?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<String?> getMovieTrailer(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/$id/videos?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final videos = data['results'];

      for (var video in videos) {
        if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
          return video['key'];
        }
      }

      return null;
    } else {
      throw Exception("Failed to load movie trailer");
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to search movies");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "ef0aa44059f4e32bfdfd1fb9fed840b9";
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['results'];
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  Future<List<dynamic>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/top_rated?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['results'];
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  Future<List<dynamic>> getUpcomingMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/upcoming?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['results'];
    } else {
      throw Exception("Failed to load upcoming movies");
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

}

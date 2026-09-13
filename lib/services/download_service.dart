import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadService {
  static const String _key = 'downloaded_movies';

  static Future<List<Map<String, dynamic>>> getDownloadedMovies() async {
    final prefs = await SharedPreferences.getInstance();

    final movies = prefs.getStringList(_key) ?? [];

    return movies
        .map((movie) => jsonDecode(movie) as Map<String, dynamic>)
        .toList();
  }

  static Future<void> addMovie(Map<String, dynamic> movie) async {
    final prefs = await SharedPreferences.getInstance();

    final movies = prefs.getStringList(_key) ?? [];

    final exists = movies.any((item) {
      final data = jsonDecode(item) as Map<String, dynamic>;
      return data['id'] == movie['id'];
    });

    if (!exists) {
      movies.add(jsonEncode(movie));
      await prefs.setStringList(_key, movies);
    }
  }

  static Future<void> removeMovie(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final movies = prefs.getStringList(_key) ?? [];

    movies.removeWhere((item) {
      final movie = jsonDecode(item) as Map<String, dynamic>;
      return movie['id'] == id;
    });

    await prefs.setStringList(_key, movies);
  }

  static Future<bool> isDownloaded(int id) async {
    final movies = await getDownloadedMovies();

    return movies.any((movie) => movie['id'] == id);
  }
}

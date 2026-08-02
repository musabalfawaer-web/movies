import 'package:flutter/material.dart';
import 'package:movies/Model/details.dart';
import '../Model/movie.dart';
import '../Model/movie_section.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  bool isLoadingToGetDetails = false;

  final ApiService apiService = ApiService();

  List<MovieSection> sections = [];
  Details? movieDetails;

  bool isLoading = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    notifyListeners();

    final popular = await apiService.getPopularMovies();
    final topRated = await apiService.getTopRatedMovies();
    final upcoming = await apiService.getUpcomingMovies();

    sections = [
      MovieSection(title: "Popular Movies", movies: convertMovies(popular)),

      MovieSection(title: "Top Rated Movies", movies: convertMovies(topRated)),

      MovieSection(title: "Upcoming Movies", movies: convertMovies(upcoming)),
    ];

    isLoading = false;
    notifyListeners();
  }

  List<Movie> convertMovies(List movies) {
    return movies.map((movie) {
      return Movie(
        id: movie['id'],
        title: movie['title'],
        posterPath: "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
        rating: movie['vote_average'].toDouble(),
      );
    }).toList();
  }

  Future<void> getMovieDetails(int id) async {
    isLoadingToGetDetails = true;
    notifyListeners();

    final data = await apiService.getMovieDetails(id);

    movieDetails = Details(
      id: data['id'],
      title: data['title'],
      posterPath: "https://image.tmdb.org/t/p/w500${data['poster_path']}",
      backdropPath: "https://image.tmdb.org/t/p/w500${data['backdrop_path']}",
      rating: (data['vote_average'] as num).toDouble(),
      overview: data['overview'],
      releaseDate: data['release_date'],
      runtime: data['runtime'] ?? 0,
      genres: data['genres'].map((e) => e['name']).toList(),
    );

    isLoadingToGetDetails = false;
    notifyListeners();
  }
}

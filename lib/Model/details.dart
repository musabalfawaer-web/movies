class Details {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double rating;
  final String releaseDate;
  final int runtime;
  final List genres;

  Details({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
  });
}

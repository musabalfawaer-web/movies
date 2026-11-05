import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/services/api_service.dart';
import 'package:movies/services/favorite_service.dart';
import 'package:movies/views/details/reviews.dart';
import 'package:movies/views/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../auth_page/sign_in.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MovieProvider? _movieProvider;

  final ApiService apiService = ApiService();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    _movieProvider = Provider.of<MovieProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _movieProvider!.getMovieDetails(widget.id);

      if (!mounted) return;

      // Only check favorites if the user is logged in.
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      final favorite = await FavoriteService.isFavorite(widget.id);

      if (mounted) {
        setState(() {
          isFavorite = favorite;
        });
      }
    });
  }

  Future<void> playTrailer() async {
    try {
      final trailerKey = await apiService.getMovieTrailer(widget.id);

      if (!mounted) return;

      if (trailerKey == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Trailer not found")));
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.black,
            content: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: trailerKey,
                flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
              ),
              showVideoProgressIndicator: true,
            ),
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load trailer")));
    }
  }

  Future<void> toggleFavorite() async {
    // Check if user is logged in.
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text(
              "Login Required",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Please sign in to add movies to your favorites.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    final movie = _movieProvider!.movieDetails!;

    // Remove from favorites.
    if (isFavorite) {
      await FavoriteService.removeMovie(movie.id);

      if (!mounted) return;

      setState(() {
        isFavorite = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Movie removed from Favorites")),
      );

      return;
    }

    // Add to favorites.
    await FavoriteService.addMovie({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'backdropPath': movie.backdropPath,
      'releaseDate': movie.releaseDate,
      'runtime': movie.runtime,
      'rating': movie.rating,
      'overview': movie.overview,
      'genres': movie.genres,
    });

    if (!mounted) return;

    setState(() {
      isFavorite = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Movie added to Favorites")));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    if (provider.isLoadingToGetDetails || provider.movieDetails == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final movie = provider.movieDetails!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,

        iconTheme: const IconThemeData(color: Colors.white),

        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  movie.backdropPath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Image.network(
                    movie.posterPath,
                    width: 120,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    "${movie.releaseDate.substring(0, 4)}  •  ${movie.runtime} min",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.genres.join(" • "),
                    style: const TextStyle(color: Colors.purple),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),

                      const SizedBox(width: 5),

                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),

                      const Spacer(),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OverviewReviews(movie: movie),
                            ),
                          );
                        },
                        child: const Text('See Reviews'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: playTrailer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Play"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: toggleFavorite,

                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),

                          label: Text(isFavorite ? "Favorited" : "Favorite"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

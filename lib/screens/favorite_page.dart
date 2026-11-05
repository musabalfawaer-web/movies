import 'package:flutter/material.dart';
import 'package:movies/services/favorite_service.dart';
import 'package:movies/views/details/movie_details.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favoriteMovies = await FavoriteService.getFavoriteMovies();

    if (!mounted) return;

    setState(() {
      movies = favoriteMovies;
      isLoading = false;
    });
  }

  Future<void> deleteMovie(int id) async {
    await FavoriteService.removeMovie(id);

    await loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Favorites",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      )
          : movies.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 70,
              color: Colors.grey,
            ),
            SizedBox(height: 15),
            Text(
              "No favorite movies",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Dismissible(
            key: Key(movie['id'].toString()),
            direction: DismissDirection.endToStart,

            background: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),

            onDismissed: (_) {
              deleteMovie(movie['id']);
            },

            child: Card(
              margin: const EdgeInsets.only(bottom: 12),

              child: ListTile(
                contentPadding: const EdgeInsets.all(8),

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),

                  child: Image.network(
                    movie['posterPath'],
                    width: 70,
                    height: 100,
                    fit: BoxFit.cover,

                    errorBuilder:
                        (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: 100,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.movie,
                        ),
                      );
                    },
                  ),
                ),

                title: Text(
                  movie['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  "Rating: ${movie['rating']}",
                ),

                trailing: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        id: movie['id'],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
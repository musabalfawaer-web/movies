import 'package:flutter/material.dart';
import 'package:movies/services/api_service.dart';
import 'package:movies/views/details/movie_details.dart';

class SeeAllPage extends StatefulWidget {
  final String collectionTitle;

  const SeeAllPage({super.key, required this.collectionTitle});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  final ApiService apiService = ApiService();
  final ScrollController scrollController = ScrollController();

  List<dynamic> movies = [];

  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    loadMovies();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        if (!isLoading && hasMore) {
          loadMovies();
        }
      }
    });
  }

  Future<void> loadMovies() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newMovies = await apiService.getMoviesByCollection(
        widget.collectionTitle,
        currentPage,
      );

      if (!mounted) return;

      setState(() {
        movies.addAll(newMovies);
        currentPage++;

        if (newMovies.isEmpty) {
          hasMore = false;
        }

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load movies")));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.collectionTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: movies.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : movies.isEmpty
          ? const Center(
              child: Text("No movies found", style: TextStyle(fontSize: 18)),
            )
          : GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 15,
                childAspectRatio: 0.62,
              ),
              itemCount: movies.length + (isLoading ? 2 : 0),
              itemBuilder: (context, index) {
                if (index >= movies.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final movie = movies[index];

                final int movieId = movie['id'];

                final String title = movie['title'] ?? "Unknown";

                final String posterPath = movie['poster_path'] != null
                    ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                    : "";

                final double rating = (movie['vote_average'] ?? 0).toDouble();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(id: movieId),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: posterPath.isNotEmpty
                              ? Image.network(
                                  posterPath,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(Icons.movie, size: 50),
                                  ),
                                ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies/views/details/movie_details.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  final ApiService apiService = ApiService();

  List<dynamic> movies = [];
  bool isLoading = false;

  Future<void> searchMovies() async {
    final query = controller.text.trim();

    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
      movies = [];
    });

    try {
      final result = await apiService.searchMovies(query);

      setState(() {
        movies = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('حدث خطأ أثناء البحث')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onSubmitted: (_) {
            searchMovies();
          },
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: searchMovies),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movies.isEmpty
          ? const Center(
              child: Text('Search for a movie', style: TextStyle(fontSize: 18)),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 15,
                childAspectRatio: 0.62,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                final String title = movie['title'] ?? 'Unknown';

                final String? posterPath = movie['poster_path'];

                final double rating = (movie['vote_average'] ?? 0).toDouble();

                return InkWell(
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
                borderRadius: BorderRadius.circular(12),
                  child:Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w500$posterPath',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                  )
                );
              },
            ),
    );
  }
}

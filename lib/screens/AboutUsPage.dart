import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(Icons.movie, color: Colors.white, size: 55),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                "Movies",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                "Your Movie Experience",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "About Us",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Movies is a movie discovery application designed "
              "to make it easier for you to explore and discover "
              "movies you may enjoy.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "What You Can Do",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            _buildFeature(
              icon: Icons.search,
              title: "Discover Movies",
              description: "Search and explore a wide variety of movies.",
            ),

            _buildFeature(
              icon: Icons.star,
              title: "Movie Details",
              description:
                  "View ratings, genres, release dates, reviews and more.",
            ),

            _buildFeature(
              icon: Icons.play_circle_outline,
              title: "Watch Trailers",
              description:
                  "Watch available movie trailers directly from the app.",
            ),

            _buildFeature(
              icon: Icons.favorite,
              title: "Favorites",
              description: "Save your favorite movies and access them anytime.",
            ),

            const SizedBox(height: 25),

            const Text(
              "Our Goal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Our goal is to provide a simple and enjoyable "
              "movie browsing experience, helping users discover "
              "new movies and keep track of the movies they love.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: Column(
                children: [
                  const Text(
                    "Version 1.0.0",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "© ${DateTime.now().year} Movies",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(icon, color: Colors.white, size: 24),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

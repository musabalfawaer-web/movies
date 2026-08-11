import 'package:flutter/material.dart';
import 'package:movies/Model/details.dart';

class OverviewReviews extends StatelessWidget {
  final Details movie;

  const OverviewReviews({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overview",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            movie.overview.isNotEmpty
                ? movie.overview
                : "No overview available.",
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),

          const SizedBox(height: 25),

          const Text(
            "Reviews",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          const Text(
            "Reviews will be available soon.",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

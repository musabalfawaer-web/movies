import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Model/details.dart';

class OverviewReviews extends StatefulWidget {
  final Details movie;

  const OverviewReviews({super.key, required this.movie});

  @override
  State<OverviewReviews> createState() => _OverviewReviewsState();
}

class _OverviewReviewsState extends State<OverviewReviews> {
  List reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReviews();
  }

  Future<void> getReviews() async {
    const apiKey = 'ef0aa44059f4e32bfdfd1fb9fed840b9';
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/${widget.movie.id}/reviews?api_key=$apiKey',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        reviews = data['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Reviews',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.movie.overview.isNotEmpty
                  ? widget.movie.overview
                  : "No overview available.",
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 25),
            const Text(
              "Reviews",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (reviews.isEmpty)
              const Text(
                "No reviews available.",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ReviewCard(review: review);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatefulWidget {
  final dynamic review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final content = widget.review['content'] ?? '';
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.review['author'] ?? 'Unknown',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (widget.review['author_details']?['rating'] != null)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text('${widget.review['author_details']['rating']}/10'),
                ],
              ),
            const SizedBox(height: 10),
            Text(
              content,
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            if (content.length > 200) ...[
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "See less" : "See more",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

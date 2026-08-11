import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/views/home/home_page.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MovieProvider? _movieProvider;

  @override
  void initState() {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _movieProvider!.getMovieDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          provider.movieDetails!.title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          const Spacer(),
          IconButton(onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage(),
              ),
            );
          }, icon: const Icon(Icons.home)),
        ],
        backgroundColor: Colors.red,
      ),

      body: provider.isLoadingToGetDetails
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  provider.movieDetails!.backdropPath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Image.network(
                    provider.movieDetails!.posterPath,
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
                    "${provider.movieDetails!.releaseDate.substring(0, 4)}  "
                        "•  ${provider.movieDetails!.runtime} min",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    provider.movieDetails!.genres.join(" • "),
                    style: const TextStyle(color: Colors.purple),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),

                      Text(
                        provider.movieDetails!.rating.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Play"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Download"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    provider.movieDetails!.overview,
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

import 'package:flutter/material.dart';
import 'package:movies/views/details/movie_details.dart';
import 'package:provider/provider.dart';
import '../../Model/movie.dart';
import '../../providers/movie_provider.dart';
import '../../widgets/featured_movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Zeymar Movie',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              if (movieProvider.isLoading) const CircularProgressIndicator(),

              ...movieProvider.sections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          section.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See All",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 250,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemCount: section.movies.length,

                        itemBuilder: (context, index) {
                          return InkWell(
                            child: FeaturedMovieCard(
                              movie: section.movies[index],
                            ),
                            onTap: () {
                              int id = section.movies[index].id;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(id: id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

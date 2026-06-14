import 'package:flutter/material.dart';

import 'movie.dart';
import 'movie_service.dart';
import 'movie_detail_screen.dart';

void runLab8B() {
  runApp(const Lab8BApp());
}

class Lab8BApp extends StatelessWidget {
  const Lab8BApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8B',
      home: const MovieListScreen(),
    );
  }
}

class MovieListScreen
    extends StatefulWidget {

  const MovieListScreen({
    super.key,
  });

  @override
  State<MovieListScreen>
      createState() =>
          _MovieListScreenState();
}

class _MovieListScreenState
    extends State<MovieListScreen> {

  final MovieService service =
      MovieService();

  late Future<List<Movie>>
      futureMovies;

  @override
  void initState() {
    super.initState();

    futureMovies =
        service.fetchMovies();
  }

  void reload() {
    setState(() {
      futureMovies =
          service.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          "Lab8B - Rest API Demo",
        ),
      ),

      body: FutureBuilder<
          List<Movie>>(
        future: futureMovies,

        builder:
            (context, snapshot) {

          // Loading
          if (snapshot
                  .connectionState ==
              ConnectionState
                  .waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {

            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children: [

                  const Text(
                    "Failed to load movies",
                  ),

                  const SizedBox(
                      height: 16),

                  ElevatedButton(
                    onPressed:
                        reload,
                    child:
                        const Text(
                      "Retry",
                    ),
                  ),
                ],
              ),
            );
          }

          // Data
          if (snapshot.hasData) {

            final movies =
                snapshot.data!;

            return ListView.builder(
              itemCount:
                  movies.length,

              itemBuilder:
                  (context, index) {

                final movie =
                    movies[index];

                return Card(
                  margin:
                      const EdgeInsets
                          .all(8),

                  child: ListTile(

                    leading:
                        CircleAvatar(
                      child: Text(
                        movie.id
                            .toString(),
                      ),
                    ),

                    title: Text(
                      movie.title,
                    ),

                    subtitle:
                        const Text(
                      "Tap to view details",
                    ),

                    trailing:
                        const Icon(
                      Icons
                          .arrow_forward_ios,
                    ),

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MovieDetailScreen(
                            movie:
                                movie,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child:
                Text("No Data"),
          );
        },
      ),
    );
  }
}
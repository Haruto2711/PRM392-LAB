import 'package:flutter/material.dart';

void runLab5() {
  runApp(const MovieApp());
}

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

// Dữ liệu mẫu theo yêu cầu Lab (không dùng API)
final List<Movie> movies = [
  Movie(
    id: 1,
    title: "Dune: Part Two",
    posterUrl:
        "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba",
    overview:
        "Paul Atreides unites with Chani and the Fremen while seeking revenge against those who destroyed his family.",
    genres: ["Sci-Fi", "Adventure", "Drama"],
    rating: 8.6,
    trailers: [
      "Official Trailer #1",
      "IMAX Sneak Peek",
    ],
  ),

  Movie(
    id: 2,
    title: "Deadpool & Wolverine",
    posterUrl:
        "https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c",
    overview:
        "The multiverse gets messy when Wade Wilson teams up with Wolverine.",
    genres: ["Action", "Comedy"],
    rating: 8.3,
    trailers: [
      "Red Band Trailer",
      "Behind The Scenes",
    ],
  ),
];

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movie App",
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),

      body: ListView.builder(
        itemCount: movies.length,

        itemBuilder: (context, index) {
          final movie = movies[index];

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              title: Text(movie.title),

              subtitle: Text(
                "⭐ ${movie.rating} • ${movie.genres.join(", ")}",
              ),

              trailing: const Icon(Icons.arrow_forward_ios),

              // Điều hướng sang màn hình chi tiết
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(
                      movie: movie,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState
    extends State<MovieDetailScreen> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // Hero Banner
            Stack(
              children: [

                Image.network(
                  widget.movie.posterUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    widget.movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Genres
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                      horizontal: 12),

              child: Wrap(
                spacing: 8,

                children: widget.movie.genres
                    .map(
                      (genre) => Chip(
                        label: Text(genre),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Overview
            Padding(
              padding:
                  const EdgeInsets.all(12),

              child: Text(
                widget.movie.overview,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const Divider(),

            // Action Buttons
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

              children: [

                IconButton(
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),

                  onPressed: () {
                    setState(() {
                      isFavorite =
                          !isFavorite;
                    });
                  },
                ),

                IconButton(
                  icon:
                      const Icon(Icons.star),
                  onPressed: () {},
                ),

                IconButton(
                  icon:
                      const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Trailers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            // Danh sách trailer
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  widget.movie.trailers.length,

              itemBuilder:
                  (context, index) {

                return ListTile(
                  leading:
                      const Icon(Icons.play_circle),

                  title: Text(
                    widget.movie
                        .trailers[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
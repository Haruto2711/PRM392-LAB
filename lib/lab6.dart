import 'package:flutter/material.dart';

void runLab6() {
  runApp(const ResponsiveMovieApp());
}

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: "Dune Part Two",
    year: 2024,
    genres: ["Action", "Drama"],
    posterUrl: "https://picsum.photos/200/300?1",
    rating: 8.6,
  ),
  Movie(
    title: "Deadpool & Wolverine",
    year: 2024,
    genres: ["Action", "Comedy"],
    posterUrl: "https://picsum.photos/200/300?2",
    rating: 8.3,
  ),
  Movie(
    title: "Interstellar",
    year: 2014,
    genres: ["Drama", "Sci-Fi"],
    posterUrl: "https://picsum.photos/200/300?3",
    rating: 8.7,
  ),
  Movie(
    title: "Joker",
    year: 2019,
    genres: ["Drama"],
    posterUrl: "https://picsum.photos/200/300?4",
    rating: 8.4,
  ),
];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lab 6",
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Nội dung tìm kiếm
  String searchQuery = '';

  // Thể loại được chọn
  final Set<String> selectedGenres = {};

  // Giá trị sắp xếp mặc định
  String selectedSort = "A-Z";

  // Danh sách thể loại
  final List<String> genres = ["Action", "Drama", "Comedy", "Sci-Fi"];

  @override
  Widget build(BuildContext context) {
    // Lọc phim theo từ khóa
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final matchesGenre =
          selectedGenres.isEmpty ||
          movie.genres.any((g) => selectedGenres.contains(g));

      return matchesSearch && matchesGenre;
    }).toList();

    // Sắp xếp danh sách
    if (selectedSort == "A-Z") {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    }

    if (selectedSort == "Z-A") {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    }

    if (selectedSort == "Year") {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year));
    }

    if (selectedSort == "Rating") {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Lab 6")),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Heading
              const Text(
                "Find a Movie",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search movie...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: genres.map((genre) {
                  final selected = selectedGenres.contains(genre);

                  return FilterChip(
                    label: Text(genre),

                    selected: selected,

                    onSelected: (value) {
                      setState(() {
                        if (selected) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              DropdownButton<String>(
                value: selectedSort,

                items: const [
                  DropdownMenuItem(value: "A-Z", child: Text("A-Z")),
                  DropdownMenuItem(value: "Z-A", child: Text("Z-A")),
                  DropdownMenuItem(value: "Year", child: Text("Year")),
                  DropdownMenuItem(value: "Rating", child: Text("Rating")),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedSort = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Tablet / Web
                    if (constraints.maxWidth >= 800) {
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.2,

                        children: visibleMovies.map((movie) {
                          return MovieCard(movie: movie);
                        }).toList(),
                      );
                    }

                    // Phone
                    return ListView.builder(
                      itemCount: visibleMovies.length,

                      itemBuilder: (context, index) {
                        return MovieCard(movie: visibleMovies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            // Poster
            Image.network(
              movie.posterUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Year: ${movie.year}"),

                  Text("⭐ ${movie.rating}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

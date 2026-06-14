import 'dart:convert';
import 'package:http/http.dart' as http;

import 'movie.dart';

class MovieService {

  Future<List<Movie>> fetchMovies() async {

    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (item) => Movie.fromJson(item),
          )
          .toList();
    }

    throw Exception(
      'Failed to load movies',
    );
  }
}
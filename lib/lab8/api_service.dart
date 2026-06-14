import 'dart:convert';
import 'package:http/http.dart' as http;

import 'post.dart';

class ApiService {

  Future<List<Post>> fetchPosts() async {

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
            (item) => Post.fromJson(item),
          )
          .toList();
    }

    throw Exception(
      'Failed to load posts',
    );
  }
}
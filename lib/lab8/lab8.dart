import 'package:flutter/material.dart';

import 'api_service.dart';
import 'post.dart';

void runLab8() {
  runApp(const Lab8App());
}

class Lab8App extends StatelessWidget {
  const Lab8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8',
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatelessWidget {
  PostListScreen({super.key});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 8 API Demo')),

      body: FutureBuilder<List<Post>>(
        future: apiService.fetchPosts(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Data
          if (snapshot.hasData) {
            final posts = snapshot.data!;

            return ListView.builder(
              itemCount: posts.length,

              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.all(8),

                  child: ListTile(
                    leading: CircleAvatar(child: Text(post.id.toString())),

                    title: Text(post.title),

                    subtitle: Text(
                      post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}

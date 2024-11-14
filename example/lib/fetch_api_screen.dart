import 'dart:convert';
import 'dart:developer';

import 'package:example/post.dart';
import 'package:flutter/material.dart';
import 'package:state_management_package/state_management_package.dart';
import 'package:http/http.dart' as http;

class FetchApiScreen extends StatefulWidget {
  const FetchApiScreen({super.key});

  @override
  State<FetchApiScreen> createState() => _FetchApiScreenState();
}

class _FetchApiScreenState extends State<FetchApiScreen> {
  final StateProvider<FetchApiState> fetchApiProvider =
      StateProvider<FetchApiState>(
          StateNotifier<FetchApiState>(FetchApiState()));

  Future<List<Post>> fetchPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      final response = await http.get(Uri.parse(url));
      log(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<Post> posts = [];
        jsonData.forEach((element) {
          posts.add(Post.fromJson(element));
        });
        return posts;
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fetch API")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StateBuilder(
              provider: fetchApiProvider,
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.posts.isEmpty) {
                  return const Text("No data");
                } else {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                        );
                      },
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.posts[index].title ?? ''),
                          ),
                        );
                      },
                      itemCount: state.posts.length,
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    fetchApiProvider.update(
                        fetchApiProvider.state.copyWith(isLoading: true));
                    List<Post> posts = await fetchPosts();
                    fetchApiProvider.update(fetchApiProvider.state
                        .copyWith(posts: posts, isLoading: false));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Call API",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                GestureDetector(
                  onTap: () async {
                    fetchApiProvider.reset(FetchApiState());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Clear data",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FetchApiState {
  bool isLoading;
  bool isError;
  List<Post> posts;

  FetchApiState({
    this.isLoading = false,
    this.isError = false,
    this.posts = const [],
  });

  FetchApiState copyWith({
    bool? isLoading,
    bool? isError,
    List<Post>? posts,
  }) {
    return FetchApiState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      posts: posts ?? this.posts,
    );
  }
}

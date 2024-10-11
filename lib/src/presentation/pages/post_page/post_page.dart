import 'package:flutter/material.dart';
import 'package:kkw_blog/src/domain/models/post.dart';

class PostPage extends StatelessWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
      title: post.title,
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: kToolbarHeight,
            ),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

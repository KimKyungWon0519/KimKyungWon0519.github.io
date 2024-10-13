import 'package:flutter/material.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/widgets/tags.dart';
import 'package:kkw_blog/src/presentation/widgets/upload_date_and_category.dart';

class Header extends StatelessWidget {
  final Post post;

  const Header({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(post.title),
        const SizedBox(height: 8),
        UploadDateAndCategory(
          createAt: post.createAtToString,
          category: post.category,
        ),
        const SizedBox(height: 8),
        Tags(tags: post.tags),
        _Thumbnail(post.thumbnail),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String thumbnail;

  const _Thumbnail(this.thumbnail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      thumbnail,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
          Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: child,
      ),
      errorBuilder: (context, error, stackTrace) => const SizedBox(),
    );
  }
}

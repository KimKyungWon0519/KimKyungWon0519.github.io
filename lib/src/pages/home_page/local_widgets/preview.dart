import 'package:flutter/material.dart';
import 'package:kkw_blog/src/utils/models/post.dart';
import 'package:kkw_blog/src/pages/post_page/post_page.dart';

class Preview extends StatelessWidget {
  final Post post;

  const Preview({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(post: post),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.thumbnail != null) ...[
                    _Image(
                      post.thumbnail!,
                      height: constraints.maxWidth * 0.5,
                    ),
                    const SizedBox(height: 10),
                  ],
                  _Title(post.title),
                  _Description(post.description),
                  const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        _Category(post.catetory),
                        const VerticalDivider(),
                        _UploadDate(post.createdAt),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  final double? height;
  final String path;

  const _Image(
    this.path, {
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Category extends StatelessWidget {
  final String text;

  const _Category(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _UploadDate extends StatelessWidget {
  final String createAt;

  const _UploadDate(this.createAt);

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattigDate(),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
          ),
    );
  }

  String _formattigDate() {
    String newTypeDate = createAt;

    newTypeDate = newTypeDate.replaceFirst('-', '년 ');
    newTypeDate = newTypeDate.replaceFirst('-', '월 ');

    newTypeDate += '일';

    return newTypeDate;
  }
}

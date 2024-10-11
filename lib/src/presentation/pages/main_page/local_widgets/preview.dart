import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kkw_blog/src/core/routes/app_routes.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:markdown/markdown.dart' as Markdown;

class Preview extends StatelessWidget {
  final Post post;

  const Preview({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/${post.id}', extra: post),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: _addSpacing(
              [
                _UploadDateAndCategory(
                  createAt: post.createAt,
                  category: post.category,
                ),
                _Thumbnail(height: constraints.maxWidth * 0.5),
                _Content(
                  title: post.title,
                  content: post.content,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: _Tags(tags: post.tags),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _addSpacing(List<Widget> children) {
    return children
        .expand(
          (element) => [
            element,
            const SizedBox(height: 8),
          ],
        )
        .toList()
      ..removeLast();
  }
}

class _UploadDateAndCategory extends StatelessWidget {
  final DateTime createAt;
  final String category;

  const _UploadDateAndCategory({
    required this.createAt,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(DateFormat('yyyy년 MM월 dd일').format(createAt)),
          const VerticalDivider(),
          Text(
            category,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final double height;

  const _Thumbnail({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://images-assets.nasa.gov/image/PIA00122/PIA00122~small.jpg',
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _Content extends StatelessWidget {
  final String title;
  final String content;

  const _Content({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Text(
          _removeMarkdownFormat(content),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _removeMarkdownFormat(String markdown) {
    return Markdown.markdownToHtml(markdown)
        .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }
}

class _Tags extends StatelessWidget {
  final List<String> tags;

  const _Tags({
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags
          .map((tag) => Text(
                tag,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ))
          .toList(),
    );
  }
}

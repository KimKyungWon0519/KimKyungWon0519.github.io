import 'package:yaml/yaml.dart';

class Post {
  final String title;
  final String description;
  final String catetory;
  final List<String> tags;
  final String createdAt;
  final String? thumbnail;

  final String content;

  const Post({
    required this.title,
    required this.description,
    required this.catetory,
    required this.tags,
    required this.createdAt,
    required this.thumbnail,
    required this.content,
  });

  factory Post.withYaml({
    required YamlMap yaml,
    required String catetory,
    required String content,
  }) =>
      Post(
        title: yaml['title'],
        description: yaml['description'],
        catetory: catetory,
        tags: (yaml['tags'] as YamlList).toList().cast<String>(),
        createdAt: yaml['createdAt'],
        thumbnail: yaml['thumbnail'],
        content: content,
      );

  @override
  String toString() {
    return '(Post)[title : $title, description: $description, catetory: $catetory, tags: $tags, createdAt: $createdAt, thumbnail: $thumbnail, content: $content]';
  }
}

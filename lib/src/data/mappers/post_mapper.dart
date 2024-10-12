import 'package:kkw_blog/src/core/utils/markdown.dart';
import 'package:kkw_blog/src/core/utils/markdown_formatter.dart';
import 'package:kkw_blog/src/data/entities/post.dart' as Entity;
import 'package:kkw_blog/src/domain/models/post.dart' as Model;
import 'package:yaml/yaml.dart';

class PostMapper {
  const PostMapper._();

  static Model.Post createPost({
    required Entity.Post post,
    required Markdown markdown,
  }) {
    YamlMap frontMatter = markdown.getFrontMatter();
    String content = markdown.getContent();

    return Model.Post(
      id: post.name,
      title: frontMatter['title'],
      content: content,
      category: post.categoryName,
      tags: post.tagsNames,
      createAt: post.createAt,
    );
  }
}

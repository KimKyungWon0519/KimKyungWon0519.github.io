import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:yaml/yaml.dart';

class MarkdownFormatter {
  const MarkdownFormatter._();

  static YamlMap getFrontMatter(String markdown) {
    int closeIndex = markdown.lastIndexOf(frontMatterDelimiter);
    String frontMatterRaw =
        markdown.substring(frontMatterDelimiter.length, closeIndex);

    return loadYaml(frontMatterRaw);
  }

  static String getContent(String markdown) {
    int closeIndex = markdown.lastIndexOf(frontMatterDelimiter);

    return markdown.substring(closeIndex + frontMatterDelimiter.length).trim();
  }
}

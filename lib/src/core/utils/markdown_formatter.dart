import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:kkw_blog/src/core/utils/markdown.dart';
import 'package:yaml/yaml.dart';

extension MarkdownFormatter on Markdown {
  YamlMap getFrontMatter() {
    int closeIndex = content.lastIndexOf(frontMatterDelimiter);
    String frontMatterRaw =
        content.substring(frontMatterDelimiter.length, closeIndex);

    return loadYaml(frontMatterRaw);
  }

  String getContent() {
    int closeIndex = content.lastIndexOf(frontMatterDelimiter);

    return content.substring(closeIndex + frontMatterDelimiter.length).trim();
  }
}

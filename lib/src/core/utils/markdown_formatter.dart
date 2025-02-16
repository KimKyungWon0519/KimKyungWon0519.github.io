import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:kkw_blog/src/core/utils/markdown.dart';
import 'package:yaml/yaml.dart';

extension MarkdownFormatter on Markdown {
  YamlMap getFrontMatter() {
    int closeIndex = content.lastIndexOf(frontMatterDelimiter);
    String frontMatterRaw =
        content.substring(frontMatterDelimiter.length, closeIndex);

    return loadYaml(frontMatterRaw) as YamlMap;
  }

  String getContent() {
    int closeIndex = content.lastIndexOf(frontMatterDelimiter);

    return content.substring(closeIndex + frontMatterDelimiter.length).trim();
  }
}

extension CodeBlockFormatter on String {
  YamlMap getFrontMatter() {
    int closeIndex = indexOf('\n');

    String frontMatterRaw = substring(0, closeIndex);

    return loadYaml(frontMatterRaw) as YamlMap;
  }

  String getContent() {
    int closeIndex = indexOf('\n');

    return substring(closeIndex).trim();
  }
}

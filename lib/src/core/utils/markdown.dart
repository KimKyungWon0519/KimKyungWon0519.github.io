import 'package:freezed_annotation/freezed_annotation.dart';

part 'markdown.freezed.dart';

@freezed
class Markdown with _$Markdown {
  const factory Markdown({
    required String path,
    required String content,
  }) = _Markdown;
}

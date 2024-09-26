import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    required DateTime createAt,
    required String? thumbnail,
  }) = _Post;
}

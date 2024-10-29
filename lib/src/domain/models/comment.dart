import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/domain/models/user.dart';

part 'comment.freezed.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    int? id,
    required User user,
    required String content,
    DateTime? createAt,
    required int postID,
  }) = _Comment;
}

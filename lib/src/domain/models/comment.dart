import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    int? id,
    required String userUUID,
    required String userName,
    required String content,
    DateTime? createAt,
    required int postID,
  }) = _Comment;
}

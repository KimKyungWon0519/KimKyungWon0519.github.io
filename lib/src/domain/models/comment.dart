import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String userUUID,
    required String userName,
    required String content,
    required DateTime createAt,
  }) = _Comment;
}

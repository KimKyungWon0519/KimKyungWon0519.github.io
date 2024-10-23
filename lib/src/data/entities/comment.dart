import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required int? id,
    required String content,
    required String userUUID,
    @JsonKey(name: CommentsTable.createAt) required DateTime createAt,
    @JsonKey(name: CommentsTable.postID) required int postID,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

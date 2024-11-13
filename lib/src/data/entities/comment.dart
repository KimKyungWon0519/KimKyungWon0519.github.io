import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    @JsonKey(includeToJson: false) required int? id,
    required String content,
    @JsonKey(name: CommentsTable.userUUID) required String userUUID,
    @JsonKey(
      name: CommentsTable.createAt,
      includeToJson: false,
    )
    required DateTime? createAt,
    @JsonKey(name: CommentsTable.postID) required int postID,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

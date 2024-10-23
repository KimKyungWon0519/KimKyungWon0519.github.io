import 'package:kkw_blog/src/domain/models/comment.dart' as Model;
import 'package:kkw_blog/src/data/entities/comment.dart' as Entity;

extension CommentModelMapper on Model.Comment {
  Entity.Comment toEntity() {
    return Entity.Comment(
      id: id,
      content: content,
      userUUID: userUUID,
      createAt: createAt,
      postID: postID,
    );
  }
}

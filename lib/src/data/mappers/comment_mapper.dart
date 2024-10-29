import 'package:kkw_blog/src/domain/models/comment.dart' as Model;
import 'package:kkw_blog/src/data/entities/comment.dart' as Entity;
import 'package:kkw_blog/src/domain/models/user.dart';

extension CommentModelMapper on Model.Comment {
  Entity.Comment toEntity() {
    return Entity.Comment(
      id: id,
      content: content,
      userUUID: user.uuid,
      createAt: createAt,
      postID: postID,
    );
  }
}

extension CommentEntityMapper on Entity.Comment {
  Model.Comment toModel({required User user}) {
    return Model.Comment(
      id: id,
      content: content,
      user: user,
      createAt: createAt,
      postID: postID,
    );
  }
}

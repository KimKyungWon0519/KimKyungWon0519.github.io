import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/domain/models/favorite.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';

abstract interface class SupabaseDatabaseRepository {
  Future<int> getPostsCount();
  Future<Set<CategoryType>> getCategoriesCount();
  Future<Set<TagType>> getTagsCount();
  Future<ResponseResult> saveComment(Comment comment);
  Future<List<Comment>> getComments(int postID);
  Future<List<Favorite>> getFavorites(int postID);
}

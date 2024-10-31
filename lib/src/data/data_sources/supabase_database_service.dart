import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
import 'package:kkw_blog/src/data/entities/comment.dart';
import 'package:kkw_blog/src/data/entities/favorite.dart';
import 'package:kkw_blog/src/data/entities/post.dart';
import 'package:kkw_blog/src/data/entities/tag_count.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Post>> getPosts({
    int startOffset = 0,
    int? categoryID,
    int? tagID,
  }) {
    return _client
        .rpc<List<Map<String, dynamic>>>(
          CombineDataPostsFunction.functionName,
          params: CombineDataPostsFunction.setParameter(
            startOffset: startOffset,
            categoryID: categoryID,
            tagID: tagID,
          ),
        )
        .then((result) => result.map((data) => Post.fromJson(data)).toList());
  }

  Future<List<TagCount>> getTags() {
    return _client
        .rpc<List<Map<String, dynamic>>>(TagsCountFunction.functionName)
        .then(
            (result) => result.map((data) => TagCount.fromJson(data)).toList());
  }

  Future<int> getPostsCount() {
    return _client.from(PostsTable.table).count();
  }

  Future<List<CategoryCount>> getCategoriesCount() {
    return _client
        .rpc<List<Map<String, dynamic>>>(CategoriesCountFunction.functionName)
        .then((result) =>
            result.map((data) => CategoryCount.fromJson(data)).toList());
  }

  Future<Post> getPost(String name) {
    return _client
        .rpc<List<Map<String, dynamic>>>(
          CombineDataPostFunction.functionName,
          params: CombineDataPostFunction.setParameter(postName: name),
        )
        .then((result) => Post.fromJson(result.single));
  }

  Future<ResponseResult> saveComment(Map<String, dynamic> data) {
    return _client.from(CommentsTable.tableName).insert(data).then(
          (value) => ResponseResult.isSuccess(null),
          onError: (error, stackTrace) => ResponseResult.isFailure(error),
        );
  }

  Future<List<Comment>> getComments(int postID) {
    return _client
        .rpc<List<Map<String, dynamic>>>(
          CommentsTable.functionName,
          params: CommentsTable.setParameter(postID: postID),
        )
        .then(
            (result) => result.map((data) => Comment.fromJson(data)).toList());
  }

  Future<List<Favorite>> getFavorites(int postID) {
    return _client
        .rpc<List<Map<String, dynamic>>>(
          FavoritesTable.functionName,
          params: FavoritesTable.setParameter(postID: postID),
        )
        .then(
            (result) => result.map((data) => Favorite.fromJson(data)).toList());
  }
}

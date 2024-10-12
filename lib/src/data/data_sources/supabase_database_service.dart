import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
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
    return _client.rpc<List<Map<String, dynamic>>>(
      CombineDataPostsRPC.getPostsRPC,
      params: {
        'start_offset': startOffset,
        'p_category_id': categoryID,
        'p_tag_id': tagID,
      },
    ).then((result) => result.map((data) => Post.fromJson(data)).toList());
  }

  Future<List<TagCount>> getTags() {
    return _client.rpc<List<Map<String, dynamic>>>(TagsCountRPC.funcName).then(
        (result) => result.map((data) => TagCount.fromJson(data)).toList());
  }

  Future<int> getPostsCount() {
    return _client.from(PostsTable.table).count();
  }

  Future<List<CategoryCount>> getCategoriesCount() {
    return _client
        .rpc<List<Map<String, dynamic>>>(CategoriesCountRPC.funcName)
        .then((result) =>
            result.map((data) => CategoryCount.fromJson(data)).toList());
  }

  Future<Post> getPost(String name) {
    return _client.rpc<List<Map<String, dynamic>>>(
        CombineDataPostsRPC.getPostPRC,
        params: {
          'post_name': name,
        }).then((result) => Post.fromJson(result.single));
  }
}

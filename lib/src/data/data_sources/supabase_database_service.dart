import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
import 'package:kkw_blog/src/data/entities/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Post>> getAllPosts({int startOffset = 0}) {
    return _client.rpc<List<Map<String, dynamic>>>(
      CombineDataPostsRPC.funcName,
      params: {'start_offset': startOffset},
    ).then((result) => result.map((data) => Post.fromJson(data)).toList());
  }

  Future<List<String>> getTags(int postID) {
    return _client
        .from(PostsUsageTags.table)
        .select('${TagsTable.table}(${TagsTable.name})')
        .eq(PostsUsageTags.posts_id, postID)
        .then((value) => value
            .map((e) => (e[TagsTable.table][TagsTable.name] as String))
            .toList());
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
}

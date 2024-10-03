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

  Future<Map<String, dynamic>> getCategory(int id) {
    return _client
        .from(CategoriesTable.table)
        .select()
        .eq(CategoriesTable.id, id)
        .single();
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
    return _client.from(CombineDataPostsRPC.funcName).count();
  }

  Future<List<CategoryCount>> getCategoriesCount() {
    return _client
        .from(CategoriesTable.table)
        .select(
            '${CategoriesTable.name}, counts:${CombineDataPostsRPC.funcName}!inner(${CategoriesTable.id})')
        .then((value) =>
            value.map((json) => CategoryCount.fromJson(json)).toList());
  }
}

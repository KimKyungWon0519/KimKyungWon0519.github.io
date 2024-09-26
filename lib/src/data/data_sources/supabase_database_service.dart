import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/data/entities/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Post>> getAllPosts({int startIndex = 0, int limit = 50}) {
    return _client
        .from(PostsTable.table)
        .select()
        .order(PostsTable.createAt)
        .range(startIndex, startIndex + limit - 1)
        .then((value) => value.map((data) => Post.fromJson(data)).toList());
  }
}

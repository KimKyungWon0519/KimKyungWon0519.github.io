import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List> getAllPosts({int limit = 50}) {
    return _client.from('posts').select().limit(limit);
  }
}

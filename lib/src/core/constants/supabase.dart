const supabaseUrl = 'https://hzrvlmmdedvyxwnjunyf.supabase.co';
const supabaseKey = String.fromEnvironment('supabase_key');

final class PostsTable {
  const PostsTable._();

  static const String name = 'posts';

  static const String id = 'id';
  static const String fileName = 'file_name';
  static const String path = 'path';
  static const String uploadDate = 'upload_date';
}

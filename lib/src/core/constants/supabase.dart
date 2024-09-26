const supabaseUrl = 'https://hzrvlmmdedvyxwnjunyf.supabase.co';
const supabaseKey = String.fromEnvironment('supabase_key');

final class PostsTable {
  const PostsTable._();

  static const String table = 'posts';

  static const String id = 'id';
  static const String name = 'name';
  static const String createAt = 'create_at';
  static const String categoryID = 'category_id';
}

final class CategoriesTable {
  const CategoriesTable._();

  static const String table = 'categories';

  static const String id = 'id';
  static const String name = 'name';
}

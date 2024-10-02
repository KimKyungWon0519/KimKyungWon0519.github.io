const supabaseUrl = 'https://hzrvlmmdedvyxwnjunyf.supabase.co';
const supabaseKey = String.fromEnvironment('supabase_key');

const String postsBuckID = 'posts';

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

final class PostsUsageTags {
  const PostsUsageTags._();

  static const String table = 'posts_usage_tags';

  static const String posts_id = 'posts_id';
  static const String tags_id = 'tags_id';
}

final class TagsTable {
  const TagsTable._();

  static const String table = 'tags';

  static const String id = 'id';
  static const String name = 'name';
}

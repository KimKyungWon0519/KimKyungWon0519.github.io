const supabaseUrl = 'https://hzrvlmmdedvyxwnjunyf.supabase.co';
const supabaseKey = String.fromEnvironment('supabase_key');

const String postBucketID = 'posts';

late final String postBucketURL;

final class PostsTable {
  const PostsTable._();

  static const String table = 'posts';
}

final class CombineDataPostsRPC {
  const CombineDataPostsRPC._();

  static const String getPostsRPC = 'get_combine_data_posts';
  static const String getPostPRC = 'get_combine_data_post';

  static const String id = 'id';
  static const String name = 'name';
  static const String createAt = 'create_at';
  static const String categoryName = 'category_name';
  static const String tagsNames = 'tags_names';
}

final class CategoriesCountRPC {
  const CategoriesCountRPC._();

  static const String funcName = 'get_category_post_counts';

  static const String id = 'id';
  static const String name = 'name';
  static const String postCount = 'post_count';
}

final class TagsCountRPC {
  const TagsCountRPC._();

  static const String funcName = 'get_tag_posts_count';

  static const String id = 'id';
  static const String name = 'name';
  static const String postCount = 'post_count';
}

final class CommentsTable {
  const CommentsTable._();

  static const String tableName = 'comments';

  static const String id = 'id';
  static const String content = 'content';
  static const String userUUID = 'user_uuid';
  static const String createAt = 'create_at';
  static const String postID = 'post_id';
}

const supabaseUrl = String.fromEnvironment('supabase_url');
const supabaseAnnoKey = String.fromEnvironment('supabase_anno_key');
const supabaseRoleKey = String.fromEnvironment('supabase_role_key');

const String postBucketID = 'posts';

late final String postBucketURL;

final class PostsTable {
  const PostsTable._();

  static const String table = 'posts';
}

final class CombineDataPostsFunction {
  const CombineDataPostsFunction._();

  static const String functionName = 'get_combine_data_posts';

  static const String id = 'id';
  static const String name = 'name';
  static const String createAt = 'create_at';
  static const String categoryName = 'category_name';
  static const String tagsNames = 'tags_names';
  static const String commentsCount = 'comment_counts';

  static Map<String, dynamic> setParameter({
    required int startOffset,
    required int? categoryID,
    required int? tagID,
  }) {
    return {
      'start_offset': startOffset,
      'p_category_id': categoryID,
      'p_tag_id': tagID,
    };
  }
}

final class CombineDataPostFunction {
  const CombineDataPostFunction._();

  static const String functionName = 'get_combine_data_post';

  static const String id = 'id';
  static const String name = 'name';
  static const String createAt = 'create_at';
  static const String categoryName = 'category_name';
  static const String tagsNames = 'tags_names';
}

final class CategoriesCountFunction {
  const CategoriesCountFunction._();

  static const String functionName = 'get_category_post_counts';

  static const String id = 'id';
  static const String name = 'name';
  static const String postCount = 'post_count';
}

final class TagsCountFunction {
  const TagsCountFunction._();

  static const String functionName = 'get_tag_posts_count';

  static const String id = 'id';
  static const String name = 'name';
  static const String postCount = 'post_count';
}

final class CommentsTable {
  const CommentsTable._();

  static const String tableName = 'comments';
  static const String functionName = 'get_comments_in_post';

  static const String id = 'id';
  static const String content = 'content';
  static const String userUUID = 'user_uuid';
  static const String createAt = 'created_at';
  static const String postID = 'post_id';
}

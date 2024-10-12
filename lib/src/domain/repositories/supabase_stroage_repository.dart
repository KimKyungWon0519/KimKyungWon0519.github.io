import 'package:kkw_blog/src/domain/models/post.dart';

abstract interface class SupabaseStorageRepository {
  Future<List<Post>> getPostFiles({
    int startOffset = 0,
    int? categoryID,
    int? tagID,
  });

  Future<Post> getPostFile(String fileName);
}

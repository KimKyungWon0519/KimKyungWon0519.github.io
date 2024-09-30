import 'package:kkw_blog/src/domain/models/post.dart';

abstract interface class SupabaseStorageRepository {
  Future<List<Post>> getAllPostFiles();
}

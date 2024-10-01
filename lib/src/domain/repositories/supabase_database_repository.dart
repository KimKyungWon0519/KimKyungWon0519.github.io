import 'package:kkw_blog/src/domain/models/classification_type.dart';

abstract interface class SupabaseDatabaseRepository {
  Future<int> getPostsCount();
  Future<Set<CategoryType>> getCategoriesCount();
}

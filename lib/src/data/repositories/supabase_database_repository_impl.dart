import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';

class SupabaseDatabaseRepositoryImpl implements SupabaseDatabaseRepository {
  late final SupabaseDatabaseService _databaseService;

  SupabaseDatabaseRepositoryImpl({
    required SupabaseDatabaseService databaseSerivce,
  }) : _databaseService = databaseSerivce;

  @override
  Future<int> getPostsCount() {
    return _databaseService.getPostsCount();
  }

  @override
  Future<Set<CategoryType>> getCategoriesCount() async {
    List<CategoryCount> data = await _databaseService.getCategoriesCount();

    return data
        .map((e) => CategoryType(category: e.name, count: e.counts.length))
        .toSet();
  }
}

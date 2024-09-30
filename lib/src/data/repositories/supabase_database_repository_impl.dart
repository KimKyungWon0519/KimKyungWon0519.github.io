import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
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
}

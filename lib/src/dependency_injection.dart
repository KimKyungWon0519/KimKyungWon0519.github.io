import 'package:get_it/get_it.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_storage_service.dart';
import 'package:kkw_blog/src/data/repositories/supabase_database_repository_impl.dart';
import 'package:kkw_blog/src/data/repositories/supabase_stroage_repository_impl.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';

final GetIt instance = GetIt.instance;

void initializeDI() {
  SupabaseDatabaseService supabaseDatabaseService = SupabaseDatabaseService();
  SupabaseStorageService supabaseStorageService =
      SupabaseStorageService(postBucketID);

  postBucketURL = supabaseStorageService.getPublicUrl();

  SupabaseStorageRepository supabaseStorageRepository =
      SupabaseStorageRepositoryImpl(
    databaseService: supabaseDatabaseService,
    stroageService: supabaseStorageService,
  );

  SupabaseDatabaseRepository supabaseDatabaseRepository =
      SupabaseDatabaseRepositoryImpl(
    databaseSerivce: supabaseDatabaseService,
  );

  instance.registerSingleton(supabaseStorageRepository);
  instance.registerSingleton(supabaseDatabaseRepository);
}
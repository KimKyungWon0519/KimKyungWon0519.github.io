import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'classified_types_notifier.g.dart';

@Riverpod(keepAlive: true)
Future<AllType> allTypeNotifier(AllTypeNotifierRef ref) async {
  SupabaseDatabaseRepository databaseRepository =
      instance<SupabaseDatabaseRepository>();

  int count = await databaseRepository.getPostsCount();

  return AllType(count);
}

@Riverpod(keepAlive: true)
Future<Set<CategoryType>> categoriesNotifier(CategoriesNotifierRef ref) async {
  SupabaseDatabaseRepository databaseRepository =
      instance<SupabaseDatabaseRepository>();
  return databaseRepository.getCategoriesCount();
}

@Riverpod(keepAlive: true)
Future<Set<TagType>> tagsNotifier(TagsNotifierRef ref) async {
  SupabaseDatabaseRepository databaseRepository =
      instance<SupabaseDatabaseRepository>();

  return databaseRepository.getTagsCount();
}

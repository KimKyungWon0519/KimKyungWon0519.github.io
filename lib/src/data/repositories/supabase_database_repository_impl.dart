import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
import 'package:kkw_blog/src/data/entities/tag_count.dart';
import 'package:kkw_blog/src/data/mappers/comment_mapper.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';
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
        .map((e) => CategoryType(
              id: e.id,
              name: e.name,
              count: e.counts,
            ))
        .toSet();
  }

  @override
  Future<Set<TagType>> getTagsCount() async {
    List<TagCount> data = await _databaseService.getTags();

    return data
        .map((e) => TagType(
              id: e.id,
              name: e.name,
              count: e.counts,
            ))
        .toSet();
  }

  @override
  Future<ResponseResult> saveComment(Comment comment) {
    return _databaseService.saveComment(comment.toEntity().toJson());
  }
}

import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_auth_service.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/entities/category_count.dart';
import 'package:kkw_blog/src/data/entities/favorite.dart' as Entity;
import 'package:kkw_blog/src/data/entities/tag_count.dart';
import 'package:kkw_blog/src/data/entities/comment.dart' as Entity;
import 'package:kkw_blog/src/data/mappers/comment_mapper.dart';
import 'package:kkw_blog/src/data/mappers/favorite_mapper.dart';
import 'package:kkw_blog/src/data/mappers/user_mapper.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/comment.dart' as Model;
import 'package:kkw_blog/src/domain/models/user.dart' as Model;
import 'package:kkw_blog/src/domain/models/favorite.dart' as Model;
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseRepositoryImpl implements SupabaseDatabaseRepository {
  late final SupabaseDatabaseService _databaseService;
  late final SupabaseAuthService _authService;

  SupabaseDatabaseRepositoryImpl({
    required SupabaseDatabaseService databaseSerivce,
    required SupabaseAuthService authService,
  })  : _databaseService = databaseSerivce,
        _authService = authService;

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
  Future<ResponseResult> saveComment(Model.Comment comment) {
    return _databaseService.saveComment(comment.toEntity().toJson());
  }

  @override
  Future<List<Model.Comment>> getComments(int postID) async {
    List<Entity.Comment> commentsEntity =
        await _databaseService.getComments(postID);

    List<Model.Comment> commentsModel = [];

    for (Entity.Comment commentEntity in commentsEntity) {
      User? user = await _authService.getUser(commentEntity.userUUID);

      commentsModel.add(
        commentEntity.toModel(
          user: user != null ? user.toModel() : Model.User.unknown(),
        ),
      );
    }

    return commentsModel;
  }

  @override
  Future<List<Model.Favorite>> getFavorites(int postID) {
    return _databaseService
        .getFavorites(postID)
        .then((reuslt) => reuslt.map((data) => data.toModel()).toList());
  }
}

import 'package:flutter/foundation.dart';
import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:kkw_blog/src/core/utils/markdown.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_storage_service.dart';
import 'package:kkw_blog/src/data/entities/post.dart' as Entity;
import 'package:kkw_blog/src/data/mappers/post_mapper.dart';
import 'package:kkw_blog/src/domain/models/post.dart' as Model;
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';

class SupabaseStorageRepositoryImpl implements SupabaseStorageRepository {
  late final SupabaseDatabaseService _databaseService;
  late final SupabaseStorageService _storageService;

  SupabaseStorageRepositoryImpl({
    required SupabaseDatabaseService databaseService,
    required SupabaseStorageService stroageService,
  })  : _databaseService = databaseService,
        _storageService = stroageService;

  @override
  Future<List<Model.Post>> getAllPostFiles() async {
    List<Entity.Post> postEntities = await _databaseService.getAllPosts();

    Iterable<Future<Markdown>> downloadComputes = postEntities.map(
      (data) => compute(
        _downloadMarkdownFile,
        {
          'service': _storageService,
          'path': '${data.name}/${data.name + markdownExtension}'
        },
      ),
    );

    List<Markdown> markdowns = await Future.wait(downloadComputes);

    List<Model.Post> postModels = [];

    for (Entity.Post postEntity in postEntities) {
      List<String> tags = await _databaseService.getTags(postEntity.id);

      postModels.add(
        PostMapper.createPost(
          post: postEntity,
          thumbnail:
              _storageService.getPublicUrl('${postEntity.name}/thumbnail.png'),
          markdown: markdowns.singleWhere((element) =>
              element.path ==
              '${postEntity.name}/${postEntity.name + markdownExtension}'),
          tags: tags,
        ),
      );
    }

    return postModels;
  }

  static Future<Markdown> _downloadMarkdownFile(Map<String, dynamic> arg) {
    return (arg['service'] as SupabaseStorageService)
        .downloadMarkdownFile(path: arg['path']);
  }
}

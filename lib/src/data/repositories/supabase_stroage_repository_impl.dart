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
  Future<List<Model.Post>> getPostFiles({
    int startOffset = 0,
    int? categoryID,
    int? tagID,
  }) async {
    List<Entity.Post> postEntities = await _databaseService.getPosts(
      startOffset: startOffset,
      categoryID: categoryID,
      tagID: tagID,
    );

    Iterable<Future<Model.Post>> convertPosts = postEntities.map(
      (data) => compute(
        _convertModelPost,
        {
          'service': _storageService,
          'entity_post': data,
        },
      ),
    );

    List<Model.Post> posts = await Future.wait(convertPosts);

    return posts;
  }

  @override
  Future<Model.Post> getPostFile(String fileName) async {
    Entity.Post postEntity = await _databaseService.getPost(fileName);

    return await compute(
      _convertModelPost,
      {
        'service': _storageService,
        'entity_post': postEntity,
      },
    );
  }

  static Future<Model.Post> _convertModelPost(Map<String, dynamic> args) async {
    Entity.Post post = args['entity_post'] as Entity.Post;
    SupabaseStorageService storageService =
        args['service'] as SupabaseStorageService;

    String? thumbnail = await compute(_getThumbnail,
        {'service': storageService, 'path': '${post.name}/thumbnail.png'});

    Markdown markdown = await compute(_downloadMarkdownFile, {
      'service': storageService,
      'path': '${post.name}/${post.name + markdownExtension}'
    });

    return PostMapper.createPost(
      post: post,
      thumbnail: thumbnail,
      markdown: markdown,
    );
  }

  static Future<String?> _getThumbnail(Map<String, dynamic> args) {
    return (args['service'] as SupabaseStorageService).getFileUrl(args['path']);
  }

  static Future<Markdown> _downloadMarkdownFile(Map<String, dynamic> args) {
    return (args['service'] as SupabaseStorageService)
        .downloadMarkdownFile(path: args['path']);
  }
}

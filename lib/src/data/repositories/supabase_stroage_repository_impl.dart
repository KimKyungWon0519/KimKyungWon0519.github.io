import 'package:flutter/foundation.dart';
import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
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
    List<Entity.Post> posts = await _databaseService.getAllPosts();
    Map<int, dynamic> categories = await _getAllCategory(posts);

    Iterable<Future<Markdown>> downloadComputes = posts.map(
      (data) => compute(
        _downloadMarkdownFile,
        {
          'service': _storageService,
          'path': '${data.name}/${data.name + markdownExtension}'
        },
      ),
    );

    List<Markdown> markdowns = await Future.wait(downloadComputes);

    return posts
        .map(
          (post) => PostMapper.createPost(
            post: post,
            category: categories[post.categoryID],
            thumbnail:
                _storageService.getPublicUrl('${post.name}/thumbnail.png'),
            markdown: markdowns.singleWhere((element) =>
                element.path ==
                '${post.name}/${post.name + markdownExtension}'),
          ),
        )
        .toList();
  }

  Future<Map<int, dynamic>> _getAllCategory(List<Entity.Post> posts) async {
    Set<int> categoryIDs = posts.map((post) => post.categoryID).toSet();
    Map<int, dynamic> categories = {};

    for (int id in categoryIDs) {
      Map<String, dynamic> category = await _databaseService.getCategory(id);
      categories.addAll({
        category[CategoriesTable.id]: category[CategoriesTable.name],
      });
    }

    return categories;
  }

  static Future<Markdown> _downloadMarkdownFile(Map<String, dynamic> arg) {
    return (arg['service'] as SupabaseStorageService)
        .downloadMarkdownFile(path: arg['path']);
  }
}

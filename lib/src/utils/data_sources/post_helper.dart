import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/constants/resources.dart';
import 'package:kkw_blog/src/utils/models/categories.dart';
import 'package:kkw_blog/src/utils/models/post.dart';
import 'package:kkw_blog/src/utils/models/posts.dart';
import 'package:kkw_blog/src/utils/models/bucket_file.dart';
import 'package:kkw_blog/src/utils/models/bucket_files.dart';
import 'package:kkw_blog/src/utils/models/tags.dart';
import 'package:yaml/yaml.dart';

import 'supabase_storage_helper.dart';

class PostHelper {
  late final StorageBucketHelper _storageHelper = StorageBucketHelper('posts');

  Future<void> initializeValues() async {
    categories = await _getCategories();
    posts = await _getPosts();
    tags = _getTags();
  }

  Future<Posts> _getPosts() async {
    List<Post> posts = [];
    BucketFiles storageFiles = [];

    for (String category in categories) {
      storageFiles = await _storageHelper.getPostFileNames(category);

      for (BucketFile storageFile in storageFiles) {
        posts.add(await _getPost(storageFile, category));
      }
    }

    return Posts(posts);
  }

  Future<Categories> _getCategories() {
    return _storageHelper.getFolders().then((value) => value.toSet());
  }

  Tags _getTags() {
    Set<String> tags = {};

    for (Post post in posts) {
      tags.addAll(post.tags);
    }

    return tags;
  }

  Future<Post> _getPost(BucketFile storageFile, String category) async {
    String fileContent = await _storageHelper.downloadFile(storageFile);

    int closeIndex = fileContent.lastIndexOf(delimiter);
    String frontMatterRaw = fileContent.substring(delimiter.length, closeIndex);

    YamlMap frontMatterMap = loadYaml(frontMatterRaw);

    String content =
        fileContent.substring(closeIndex + delimiter.length).trim();

    return Post.withYaml(
      yaml: frontMatterMap,
      catetory: category,
      content: content,
    );
  }
}

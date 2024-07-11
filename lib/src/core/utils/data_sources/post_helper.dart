import 'dart:collection';

import 'package:kkw_blog/src/core/constants/resources.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:kkw_blog/src/core/utils/models/posts.dart';
import 'package:yaml/yaml.dart';

import 'bundle_helper.dart';

class PostHelper {
  final BundleHelper _bundleHelper;

  const PostHelper() : _bundleHelper = const BundleHelper();

  Future<Posts> createPosts() async {
    List<Post> posts = [];
    Map<String, dynamic> assetMap = await _bundleHelper.getAssetManifest();

    for (String assetName in assetMap.keys) {
      if (RegExp(blogsPath).hasMatch(assetName)) {
        Post post = await _getPost(assetName);

        posts.add(post);
      }
    }

    return UnmodifiableListView(posts);
  }

  Future<Post> _getPost(String assetName) async {
    String fileContent = await _bundleHelper.readFile(assetName);

    int closeIndex = fileContent.lastIndexOf(delimiter);
    String frontMatterRaw = fileContent.substring(delimiter.length, closeIndex);

    YamlMap frontMatterMap = loadYaml(frontMatterRaw);
    String content =
        fileContent.substring(closeIndex + delimiter.length).trim();
    String category = _getCategory(assetName);

    return Post.withYaml(
      yaml: frontMatterMap,
      catetory: category,
      content: content,
    );
  }

  String _getCategory(String assetName) {
    assetName = assetName.replaceAll(blogsPath, '');
    int closeIndex = assetName.lastIndexOf(r'/');

    return assetName.substring(0, closeIndex).trim();
  }
}

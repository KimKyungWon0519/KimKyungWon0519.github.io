import 'dart:convert';

import 'package:kkw_blog/src/utils/models/bucket_file.dart';
import 'package:kkw_blog/src/utils/models/bucket_files.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageBucketHelper {
  late final StorageFileApi _client;

  StorageBucketHelper(String bucketId) {
    _client = Supabase.instance.client.storage.from(bucketId);
  }

  Future<List<String>> getFolders() {
    return _client.list().then((value) => value.map((e) => e.name).toList());
  }

  Future<BucketFiles> getPostFileNames(String folder) async {
    BucketFiles postFileNames = [];
    List<String> childFolders = await _getChildFolders(folder);

    for (String childFolder in childFolders) {
      final String url = '$folder/$childFolder';

      List<String> files = await _client
          .list(path: url)
          .then((value) => value.map((e) => e.name).toList());

      String postFileName =
          files.singleWhere((element) => RegExp('.md').hasMatch(element));

      postFileNames.add(BucketFile(fileName: postFileName, url: url));
    }

    return postFileNames;
  }

  Future<String> downloadFile(BucketFile fileName) {
    return _client.download('$fileName').then((value) => utf8.decode(value));
  }

  Future<List<String>> _getChildFolders(String folder) {
    return _client
        .list(path: folder)
        .then((value) => value.map((e) => e.name).toList());
  }
}

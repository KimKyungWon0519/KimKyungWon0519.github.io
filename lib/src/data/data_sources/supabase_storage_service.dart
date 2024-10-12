import 'dart:convert';

import 'package:http/http.dart';
import 'package:kkw_blog/src/core/constants/markdown_constant.dart';
import 'package:kkw_blog/src/core/utils/markdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  late final StorageFileApi _fileAPI;

  SupabaseStorageService(String bucketID) {
    _fileAPI = Supabase.instance.client.storage.from(bucketID);
  }

  Future<String?> getFileUrl(String path) async {
    String publicUrl = _fileAPI.getPublicUrl(path);

    return await _existFile(publicUrl) ? publicUrl : null;
  }

  Future<Markdown> downloadMarkdownFile({required String path}) {
    assert(path.contains(markdownExtension));

    return _fileAPI.download(path).then((value) {
      return Markdown(
        path: path,
        content: utf8.decode(value),
      );
    });
  }

  Future<bool> _existFile(String path) {
    return Client()
        .get(Uri.parse(path))
        .then((value) => value.statusCode ~/ 100 == 2);
  }
}

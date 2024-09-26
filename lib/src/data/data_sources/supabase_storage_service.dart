import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  late final StorageFileApi _fileAPI;

  SupabaseStorageService(String bucketID) {
    _fileAPI = Supabase.instance.client.storage.from(bucketID);
  }

  Future<String> downloadMarkdownFile({required String path}) {
    assert(path.contains('.md'));

    return _fileAPI.download(path).then((value) => utf8.decode(value));
  }
}

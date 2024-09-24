import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  late final StorageFileApi _fileAPI;

  SupabaseStorageService(String bucketID) {
    _fileAPI = Supabase.instance.client.storage.from(bucketID);
  }
}

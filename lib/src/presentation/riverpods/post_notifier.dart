import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  PostNotifier()
      : _supabaseStorageRepository = instance<SupabaseStorageRepository>();

  @override
  Post? build() => null;

  void updatePost({Post? post, String? fileName}) async {
    if (fileName == null) return;

    post ??= await _supabaseStorageRepository.getPostFile(fileName);

    state = post;
  }
}

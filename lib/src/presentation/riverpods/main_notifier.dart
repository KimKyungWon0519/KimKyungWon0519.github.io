import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  @override
  ClassificationType build() {
    _supabaseStorageRepository = instance<SupabaseStorageRepository>();

    return const AllType(0);
  }

  void update(ClassificationType type) => state = type;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.freezed.dart';
part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  @override
  MainNotifierState build() {
    _supabaseStorageRepository = instance<SupabaseStorageRepository>();

    return const MainNotifierState(
      type: AllType(0),
    );
  }

  void update(ClassificationType type) => state = state.copyWith(type: type);
}

@freezed
class MainNotifierState with _$MainNotifierState {
  const factory MainNotifierState({
    required ClassificationType type,
  }) = _MainNotifierState;
}

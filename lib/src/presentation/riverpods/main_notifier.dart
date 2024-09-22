import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  @override
  ClassificationType build() => const AllType(0);

  void update(ClassificationType type) => state = type;
}

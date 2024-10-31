import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    int? id,
    required String uuid,
    required int postID,
  }) = _Favorite;
}

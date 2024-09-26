import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'posts_table_entity.freezed.dart';
part 'posts_table_entity.g.dart';

@freezed
class PostsTableEntity with _$PostsTableEntity {
  const factory PostsTableEntity({
    required int id,
    required String name,
    @JsonKey(name: PostsTable.createAt) required DateTime createAt,
    @JsonKey(name: PostsTable.categoryID) required int categoryID,
  }) = _PostsTableEntity;

  factory PostsTableEntity.fromJson(Map<String, dynamic> json) =>
      _$PostsTableEntityFromJson(json);
}

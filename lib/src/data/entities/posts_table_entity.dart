import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'posts_table_entity.freezed.dart';
part 'posts_table_entity.g.dart';

@freezed
class PostsTableEntity with _$PostsTableEntity {
  const factory PostsTableEntity({
    required int id,
    @JsonKey(name: PostsTable.fileName) required String fileName,
    required String path,
    @JsonKey(name: PostsTable.uploadDate) required DateTime uploadDate,
  }) = _PostDBEntity;

  factory PostsTableEntity.fromJson(Map<String, dynamic> json) =>
      _$PostsTableEntityFromJson(json);
}

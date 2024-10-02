import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required String name,
    @JsonKey(name: PostsTable.createAt) required DateTime createAt,
    @JsonKey(name: CategoriesTable.table, fromJson: _categoryNameFromJson)
    required String categoryName,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

String _categoryNameFromJson(Map<String, dynamic> json) =>
    json[CategoriesTable.name];

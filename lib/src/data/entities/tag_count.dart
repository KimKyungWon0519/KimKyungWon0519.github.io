import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'tag_count.freezed.dart';
part 'tag_count.g.dart';

@freezed
class TagCount with _$TagCount {
  const factory TagCount({
    required int id,
    required String name,
    @JsonKey(name: TagsCountFunction.postCount) required int counts,
  }) = _TagCount;

  factory TagCount.fromJson(Map<String, dynamic> json) =>
      _$TagCountFromJson(json);
}

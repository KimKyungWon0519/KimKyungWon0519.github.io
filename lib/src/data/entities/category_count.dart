import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'category_count.freezed.dart';
part 'category_count.g.dart';

@freezed
class CategoryCount with _$CategoryCount {
  const factory CategoryCount({
    required int id,
    required String name,
    @JsonKey(name: CategoriesCountRPC.postCount) required int counts,
  }) = _CategoryCount;

  factory CategoryCount.fromJson(Map<String, dynamic> json) =>
      _$CategoryCountFromJson(json);
}

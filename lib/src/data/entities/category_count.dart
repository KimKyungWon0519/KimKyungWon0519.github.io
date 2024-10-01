import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_count.freezed.dart';
part 'category_count.g.dart';

@freezed
class CategoryCount with _$CategoryCount {
  const factory CategoryCount({
    required String name,
    required List<Map<String, dynamic>> counts,
  }) = _CategoryCount;

  factory CategoryCount.fromJson(Map<String, dynamic> json) =>
      _$CategoryCountFromJson(json);
}

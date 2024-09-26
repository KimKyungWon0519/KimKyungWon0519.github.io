import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_table_entity.freezed.dart';
part 'categories_table_entity.g.dart';

@freezed
class CategoriesTableEntity with _$CategoriesTableEntity {
  const factory CategoriesTableEntity({
    required int id,
    required String name,
  }) = _CategoriesTableEntity;

  factory CategoriesTableEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoriesTableEntityFromJson(json);
}

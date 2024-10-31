import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const Post._();

  const factory Post({
    required int id,
    required String routeID,
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    required DateTime createAt,
    int? commentCounts,
  }) = _Post;

  String get createAtToString => DateFormat('yyyy년 MM월 dd일').format(createAt);

  String get thumbnail => '$postBucketURL$routeID/thumbnail.png';
}

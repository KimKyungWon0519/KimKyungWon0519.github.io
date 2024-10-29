import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String uuid,
    required String userName,
    required String? avatar,
  }) = _User;

  factory User.unknown() => const User(
        uuid: '',
        userName: 'UnknownUser',
        avatar: '',
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(name: 'access_token') required String accessToken,
    required String username,
  }) = _UserEntity;

  @override
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

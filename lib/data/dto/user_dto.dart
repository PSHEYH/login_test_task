import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  factory UserDto(
      {required String email,
      required String password,
      required String username}) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
    };

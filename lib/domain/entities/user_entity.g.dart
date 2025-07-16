// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      accessToken: json['access_token'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'username': instance.username,
    };

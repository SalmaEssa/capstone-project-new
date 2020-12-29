// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    token: json['token'] as String,
  )
    ..id = json['id'] as String
    ..expire = json['expire'] as String
    ..jwtToken = json['jwtToken'] as String
    ..role = json['role'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'expire': instance.expire,
      'jwtToken': instance.jwtToken,
      'role': instance.role,
      'type': instance.type,
    };

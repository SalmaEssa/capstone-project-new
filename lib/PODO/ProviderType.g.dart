// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProviderType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderType _$ProviderTypeFromJson(Map<String, dynamic> json) {
  return ProviderType(
    id: json['id'] as String,
    name: json['name'] as String,
    imageLink: json['logo'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ProviderTypeToJson(ProviderType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.imageLink,
      'querys': instance.querys,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) {
  return Region(
    json['id'] as String,
    json['name'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
    };

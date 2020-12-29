// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'City.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    json['id'] as String,
    json['name'] as String,
    (json['regions'] as List)
        ?.map((e) =>
            e == null ? null : Region.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
      'regions': instance.regions,
    };

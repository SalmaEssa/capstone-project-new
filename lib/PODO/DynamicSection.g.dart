// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DynamicSection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicSection _$DynamicSectionFromJson(Map<String, dynamic> json) {
  return DynamicSection(
    json['id'] as String,
    json['name'] as String,
    (json['offers'] as List)
        ?.map(
            (e) => e == null ? null : Offer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$DynamicSectionToJson(DynamicSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'offers': instance.offers,
      'querys': instance.querys,
    };

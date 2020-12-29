// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Provider _$ProviderFromJson(Map<String, dynamic> json) {
  return Provider(
    id: json['id'] as String,
    name: json['name'] as String,
    logoLink: json['logo_link'] as String,
    description: json['description'] as String,
  )
    ..querys = (json['querys'] as List)?.map((e) => e as String)?.toList()
    ..type = json['providerType'] == null
        ? null
        : ProviderType.fromJson(json['providerType'] as Map<String, dynamic>)
    ..branches = (json['branches'] as List)
        ?.map((e) =>
            e == null ? null : Branch.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProviderToJson(Provider instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
      'logo_link': instance.logoLink,
      'description': instance.description,
      'providerType': instance.type,
      'branches': instance.branches,
    };

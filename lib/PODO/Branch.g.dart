// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    address: json['manual_address'] as String,
    googleLocation: json['google_location_support'] as String,
    region: json['region'] == null
        ? null
        : Region.fromJson(json['region'] as Map<String, dynamic>),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    albums: (json['albums'] as List)
        ?.map((e) =>
            e == null ? null : BranchAlbum.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'manual_address': instance.address,
      'google_location_support': instance.googleLocation,
      'region': instance.region,
      'city': instance.city,
      'albums': instance.albums,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BranchAlbum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAlbum _$BranchAlbumFromJson(Map<String, dynamic> json) {
  return BranchAlbum(
    id: json['id'] as String,
    imageLink: json['image_link'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$BranchAlbumToJson(BranchAlbum instance) =>
    <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'image_link': instance.imageLink,
    };

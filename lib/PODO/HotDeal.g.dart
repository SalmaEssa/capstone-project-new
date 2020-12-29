// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HotDeal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotDeal _$HotDealFromJson(Map<String, dynamic> json) {
  return HotDeal(
    id: json['id'] as String,
    imageLink: json['photo'] as String,
    offer: json['offer'] == null
        ? null
        : Offer.fromJson(json['offer'] as Map<String, dynamic>),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$HotDealToJson(HotDeal instance) => <String, dynamic>{
      'id': instance.id,
      'photo': instance.imageLink,
      'offer': instance.offer,
      'querys': instance.querys,
    };

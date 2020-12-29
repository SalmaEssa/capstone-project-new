// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Membership _$MembershipFromJson(Map<String, dynamic> json) {
  return Membership(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      duration: json['duration'] as int,
      OffersNumber: json['OffersNumber'] as int,
      maximum_members: json['maximum_members'] as int,
      isPayed: json['is_payed'] as String,
      offers: Offer.fromJson(json['offers'] as Map<String, dynamic>))
    ..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.description,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'duration': instance.duration,
      'OffersNumber': instance.OffersNumber,
      'maximum_members': instance.maximum_members,
      'offers': instance.offers,
      'is_payed': instance.isPayed,
      'querys': instance.querys,
    };

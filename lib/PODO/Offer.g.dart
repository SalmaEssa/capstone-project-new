// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    id: json['id'] as String,
    name: json['name'] as String,
    imageLink: json['image_link'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    axonPrice: json['axon_price'] as int,
    dueDate: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    region: json['region'] == null
        ? null
        : Region.fromJson(json['region'] as Map<String, dynamic>),
    memberships: (json['memberships'] as List)
        ?.map((e) =>
            e == null ? null : Membership.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..hotDeal = json['hotdeal'] as bool
    ..provider = json['provider'] == null
        ? null
        : Provider.fromJson(json['provider'] as Map<String, dynamic>)
    ..branches = (json['branches'] as List)
        ?.map((e) =>
            e == null ? null : Branch.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_link': instance.imageLink,
      'description': instance.description,
      'price': instance.price,
      'axon_price': instance.axonPrice,
      'due_date': instance.dueDate?.toIso8601String(),
      'hotdeal': instance.hotDeal,
      'provider': instance.provider,
      'branches': instance.branches,
      'region': instance.region,
      'memberships': instance.memberships,
      'querys': instance.querys,
    };

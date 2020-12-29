// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  print("jasoooooooooooooooooooooon  of the custumer ");
  print(json);
  return Customer(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    locale: json['locale'] as String,
    photo: json['photo'] as String,
    profileStatus: json['status'] as String,
    email: json['email'] as String,
    birthdate: json['birthdate'] as String,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    region: json['region'] == null
        ? null
        : Region.fromJson(json['region'] as Map<String, dynamic>),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'locale': instance.locale,
      //'photo': instance.photo,
      'status': instance.profileStatus,
      'email': instance.email,
      'birthdate': instance.birthdate,
      'city': instance.city,
      'region': instance.region,
    };

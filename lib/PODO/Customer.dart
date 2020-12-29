import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Region.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:fly_networking/fly.dart';
part 'Customer.g.dart';

@JsonSerializable()
class Customer implements Parser<Customer> {
  @override
  List<String> querys;
  String id;
  String name;
  String phone;
  String locale;
  String photo;
  @JsonKey(name: 'status')
  String profileStatus;
  String email;
  String birthdate;
  City city;
  Region region;

  Customer.empty();

  Customer({
    this.id,
    this.name,
    this.phone,
    this.locale,
    this.photo,
    this.profileStatus,
    this.email,
    this.birthdate,
    this.city,
    this.region,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  Customer fromJson(Map<String, dynamic> data) {
    return _$CustomerFromJson(data);
  }

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Customer parse(data) {
    return Customer.fromJson(data);
  }
}

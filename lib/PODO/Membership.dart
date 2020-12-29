import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:axon/PODO/Offer.dart';

part 'Membership.g.dart';

@JsonSerializable()
class Membership implements Parser {
  String id;
  String title;
  String description;
  String price;
  int duration;
  int OffersNumber;
  int maximum_members;
  Offer offers;
  @JsonKey(name: "is_payed")
  String isPayed;

  Membership.empty();
  @override
  List<String> querys;
  Membership(
      {this.OffersNumber,
      this.description,
      this.duration,
      this.id,
      this.isPayed,
      this.maximum_members,
      this.offers,
      this.price,
      this.title});

  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipToJson(this);

  @override
  Membership fromJson(Map<String, dynamic> data) {
    return _$MembershipFromJson(data);
  }

  @override
  dynamicParse(data) {
    List<Membership> memberships = (data as List<dynamic>)
        .map((json) => Membership.fromJson(json))
        .toList();
    return offers;
  }

  @override
  parse(data) {
    return Membership.fromJson(data);
  }
}

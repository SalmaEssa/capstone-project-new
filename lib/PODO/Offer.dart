import 'package:axon/PODO/Branch.dart';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/PODO/Provider.dart';
import 'package:axon/PODO/Region.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Offer.g.dart';

@JsonSerializable()
class Offer implements Parser {
  String id;
  String name;
  @JsonKey(name: "image_link")
  String imageLink;
  String description;
  String price;
  @JsonKey(name: "axon_price")
  int axonPrice;
  @JsonKey(name: "due_date")
  DateTime dueDate;
  @JsonKey(name: "hotdeal")
  bool hotDeal;
  Provider provider;
  List<Branch> branches;
  Region region;
  List<Membership> memberships;

  Offer.empty();

  Offer({
    this.id,
    this.name,
    this.imageLink,
    this.description,
    this.price,
    this.axonPrice,
    this.dueDate,
    this.region,
    this.memberships,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);

  @override
  Offer fromJson(Map<String, dynamic> data) {
    return _$OfferFromJson(data);
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    List<Offer> offers =
        (data as List<dynamic>).map((json) => Offer.fromJson(json)).toList();
    return offers;
  }

  @override
  parse(data) {
    return Offer.fromJson(data);
  }
}

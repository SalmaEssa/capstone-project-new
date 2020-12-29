import 'package:axon/PODO/Offer.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HotDeal.g.dart';

@JsonSerializable()
class HotDeal implements Parser {
  String id;
  @JsonKey(name: "photo")
  String imageLink;
  Offer offer;

  HotDeal.empty();

  HotDeal({this.id, this.imageLink, this.offer});

  factory HotDeal.fromJson(Map<String, dynamic> json) =>
      _$HotDealFromJson(json);

  Map<String, dynamic> toJson() => _$HotDealToJson(this);

  @override
  HotDeal fromJson(Map<String, dynamic> data) {
    return _$HotDealFromJson(data);
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    List<HotDeal> hotdeals =
        (data as List<dynamic>).map((json) => HotDeal.fromJson(json)).toList();
    return hotdeals;
  }

  @override
  parse(data) {
    HotDeal.fromJson(data);
  }
}

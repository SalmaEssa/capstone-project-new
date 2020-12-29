import 'package:axon/PODO/Offer.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DynamicSection.g.dart';

@JsonSerializable()
class DynamicSection implements Parser {
  String id;
  String name;
  List<Offer> offers;

  DynamicSection.empty();

  DynamicSection(this.id, this.name, this.offers);

  factory DynamicSection.fromJson(Map<String, dynamic> json) =>
      _$DynamicSectionFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicSectionToJson(this);

  @override
  DynamicSection fromJson(Map<String, dynamic> data) {
    return _$DynamicSectionFromJson(data);
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    List<DynamicSection> dynamicSections = (data as List<dynamic>)
        .map((json) => DynamicSection.fromJson(json))
        .toList();
    return dynamicSections;
  }

  @override
  parse(data) {
    return DynamicSection.fromJson(data);
  }
}

import 'package:axon/PODO/Branch.dart';
import 'package:axon/PODO/ProviderType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fly_networking/fly.dart';
part 'Provider.g.dart';

@JsonSerializable()
class Provider implements Parser<Provider> {
  @override
  List<String> querys;

  String id;
  String name;
  @JsonKey(name: "logo_link")
  String logoLink;
  String description;
  @JsonKey(name: "providerType")
  ProviderType type;
  List<Branch> branches;

  Provider.empty();
  Provider({this.id, this.name, this.logoLink, this.description});

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderToJson(this);

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Provider parse(data) {
    return Provider.fromJson(data);
  }
}

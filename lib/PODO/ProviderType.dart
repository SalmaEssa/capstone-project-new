import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProviderType.g.dart';

@JsonSerializable()
class ProviderType implements Parser {
  String id;
  String name;
  @JsonKey(name: "logo")
  String imageLink;

  ProviderType.empty();

  ProviderType({this.id, this.name, this.imageLink});

  factory ProviderType.fromJson(Map<String, dynamic> json) =>
      _$ProviderTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderTypeToJson(this);

  @override
  ProviderType fromJson(Map<String, dynamic> data) {
    return _$ProviderTypeFromJson(data);
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    List<ProviderType> providerTypes = (data as List<dynamic>)
        .map((json) => ProviderType.fromJson(json))
        .toList();
    return providerTypes;
  }

  @override
  parse(data) {
    ProviderType.fromJson(data);
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:fly_networking/fly.dart';
part 'Region.g.dart';

@JsonSerializable()
class Region implements Parser<Region> {
  @override
  List<String> querys;

  String id;

  String name;

  Region.empty();
  Region(
    this.id,
    this.name,
  );

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Region parse(data) {
    return Region.fromJson(data);
  }
}

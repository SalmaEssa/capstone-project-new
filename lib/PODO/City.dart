import 'package:axon/PODO/Region.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:fly_networking/fly.dart';
part 'City.g.dart';

@JsonSerializable()
class City implements Parser<City> {
  @override
  List<String> querys;

  String id;

  String name;
  List<Region> regions;

  City.empty();
  City(
    this.id,
    this.name,
    this.regions,
  );

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  dynamicParse(data) {
    return data.map((dynamic json) {
      return parse(json);
    }).toList();
  }

  @override
  City parse(data) {
    return City.fromJson(data);
  }
}

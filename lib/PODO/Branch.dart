import 'package:axon/PODO/BranchAlbum.dart';
import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Region.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fly_networking/fly.dart';
part 'Branch.g.dart';

@JsonSerializable()
class Branch implements Parser<Branch> {
  @override
  List<String> querys;

  String id;
  String name;
  String phone;
  @JsonKey(name: 'manual_address')
  String address;
  @JsonKey(name: 'google_location_support')
  String googleLocation;
  Region region;
  City city;
  List<BranchAlbum> albums;

  Branch.empty();
  Branch({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.googleLocation,
    this.region,
    this.city,
    this.albums,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

  @override
  dynamicParse(data) {
    List<Branch> branches =
        (data as List<dynamic>).map((json) => Branch.fromJson(json)).toList();
    return branches;
  }

  @override
  Branch parse(data) {
    return Branch.fromJson(data);
  }
}

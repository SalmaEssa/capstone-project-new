import 'package:json_annotation/json_annotation.dart';
import 'package:fly_networking/fly.dart';
part 'BranchAlbum.g.dart';

@JsonSerializable()
class BranchAlbum implements Parser<BranchAlbum> {
  @override
  List<String> querys;

  String id;
  @JsonKey(name: "image_link")
  String imageLink;

  BranchAlbum.empty();
  BranchAlbum({this.id, this.imageLink});

  factory BranchAlbum.fromJson(Map<String, dynamic> json) =>
      _$BranchAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$BranchAlbumToJson(this);

  @override
  dynamicParse(data) {
    List<BranchAlbum> branchAlbums = (data as List<dynamic>)
        .map((json) => BranchAlbum.fromJson(json))
        .toList();
    return branchAlbums;
  }

  @override
  BranchAlbum parse(data) {
    return BranchAlbum.fromJson(data);
  }
}

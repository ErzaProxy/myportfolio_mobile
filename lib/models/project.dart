import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Model Project yang sinkron dengan ProjectSerializer di Django REST Framework.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.nama,
    required this.tipe,
    required this.deskripsi,
    required this.thumbnail,
    required this.skillset,
    this.link = '',
    this.id,
    this.tipeDisplay = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String nama;

  @JsonKey(defaultValue: 'web')
  final String tipe;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String tipeDisplay;

  final String deskripsi;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(defaultValue: '')
  final String link;

  final String skillset;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'base_post_model.dart';

part 'protocol_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ProtocolModel extends BasePostModel {
  /// title
  @JsonKey(name: 'title')
  final String title;

  /// description
  @JsonKey(name: 'description')
  final String description;

  /// url
  @JsonKey(name: 'url')
  final String url;

  /// Constructor
  ///
  /// All Fields are mandatory
  ///
  ProtocolModel(
    int id,
    this.title,
    this.description,
    this.url,
  ) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory ProtocolModel.fromJson(Map<String, dynamic> json) =>
      _$ProtocolModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$ProtocolModelToJson(this);
}

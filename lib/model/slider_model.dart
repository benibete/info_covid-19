import 'package:json_annotation/json_annotation.dart';
import 'package:covid/model/base_post_model.dart';

part 'slider_model.g.dart';

/// Slider Model
@JsonSerializable(includeIfNull: false)
class SliderModel extends BasePostModel {
  /// Order of this slider
  @JsonKey(name: 'order')
  final int order;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'post_title')
  final String title;

  @JsonKey(name: 'url')
  final String url;

  /// Model constructor
  ///
  /// All properties are mandatory
  ///
  SliderModel({
    int id,
    this.image,
    this.title,
    this.url,
    this.order,
  }) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$SliderModelToJson(this);
}

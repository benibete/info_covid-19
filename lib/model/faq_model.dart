import 'package:json_annotation/json_annotation.dart';

import 'base_post_model.dart';

part 'faq_model.g.dart';

@JsonSerializable(includeIfNull: false)
class FaqModel extends BasePostModel {
  /// Question
  @JsonKey(name: 'question')
  final String question;

  /// Answer
  @JsonKey(name: 'answer')
  final String answer;

  /// Responsable Entity
  @JsonKey(name: 'responsableEntity')
  final String responsableEntity;

  /// Constructor
  ///
  /// All Fields are mandatory
  ///
  FaqModel(
    int id,
    this.question,
    this.answer,
    this.responsableEntity,
  ) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}

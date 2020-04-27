import 'package:json_annotation/json_annotation.dart';

import 'base_post_model.dart';

part 'detail_stats_model.g.dart';

@JsonSerializable(includeIfNull: false)
class DetailStatsModel extends BasePostModel {
  /// provinceCode
  @JsonKey(name: 'Kode_Provi')
  final int provinceCode;

  /// province
  @JsonKey(name: 'Provinsi')
  final String province;

  /// positiveCase
  @JsonKey(name: 'Kasus_Posi')
  final String positiveCase;
  
  /// recoceredCase
  @JsonKey(name: 'Kasus_Semb')
  final String recoveredCase;

  /// deathCase
  @JsonKey(name: 'Kasus_Meni')
  final String deathCase;

  /// lastUpdated
  @JsonKey(name: 'lastUpdated')
  final String lastUpdated;

  /// Constructor
  ///
  /// All Fields are mandatory
  ///
  DetailStatsModel(
    int id,
    this.provinceCode,
    this.province,
    this.positiveCase,
    this.recoveredCase,
    this.deathCase,
    this.lastUpdated
  ) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory DetailStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailStatsModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$DetailStatsModelToJson(this);
}

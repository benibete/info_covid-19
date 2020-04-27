// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) {
  return StatsModel(
    json['recovered'] as String,
    json['confirmed'] as String,
    json['suspected'] as String,
    json['awaitingResults'] as String,
    json['deaths'] as String,
    json['lastUpdated'] as String,
  );
}

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recovered', instance.recovered);
  writeNotNull('confirmed', instance.confirmed);
  writeNotNull('suspected', instance.suspected);
  writeNotNull('awaitingResults', instance.awaitingResults);
  writeNotNull('deaths', instance.deaths);
  writeNotNull('lastUpdated', instance.lastUpdated);
  return val;
}

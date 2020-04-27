// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailStatsModel _$DetailStatsModelFromJson(Map<String, dynamic> json) {
  return DetailStatsModel(
    json['ID'] as int,
    json['Kode_Provi'] as int,
    json['Provinsi'] as String,
    json['Kasus_Posi'] as String,
    json['Kasus_Semb'] as String,
    json['Kasus_Meni'] as String,
    json['lastUpdated'] as String,
  );
}

Map<String, dynamic> _$DetailStatsModelToJson(DetailStatsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('Kode_Provi', instance.provinceCode);
  writeNotNull('Provinsi', instance.province);
  writeNotNull('Kasus_Posi', instance.positiveCase);
  writeNotNull('Kasus_Semb', instance.recoveredCase);
  writeNotNull('Kasus_Meni', instance.deathCase);
  writeNotNull('lastUpdated', instance.lastUpdated);
  return val;
}

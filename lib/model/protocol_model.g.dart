// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProtocolModel _$ProtocolModelFromJson(Map<String, dynamic> json) {
  return ProtocolModel(
    json['ID'] as int,
    json['title'] as String,
    json['description'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$ProtocolModelToJson(ProtocolModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('url', instance.url);
  return val;
}

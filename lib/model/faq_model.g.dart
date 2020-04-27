// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) {
  return FaqModel(
    json['ID'] as int,
    json['question'] as String,
    json['answer'] as String,
    json['responsableEntity'] as String,
  );
}

Map<String, dynamic> _$FaqModelToJson(FaqModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('question', instance.question);
  writeNotNull('answer', instance.answer);
  writeNotNull('responsableEntity', instance.responsableEntity);
  return val;
}

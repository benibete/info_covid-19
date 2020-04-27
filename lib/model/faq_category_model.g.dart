// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqCategoryModel _$FaqCategoryModelFromJson(Map<String, dynamic> json) {
  return FaqCategoryModel(
    json['ID'] as int,
    json['name'] as String,
    json['category_id'] as int,
  );
}

Map<String, dynamic> _$FaqCategoryModelToJson(FaqCategoryModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('category_id', instance.categoryId);
  return val;
}

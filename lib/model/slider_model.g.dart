// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) {
  return SliderModel(
    id: json['ID'] as int,
    image: json['image'] as String,
    title: json['post_title'] as String,
    url: json['url'] as String,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('order', instance.order);
  writeNotNull('image', instance.image);
  writeNotNull('post_title', instance.title);
  writeNotNull('url', instance.url);
  return val;
}

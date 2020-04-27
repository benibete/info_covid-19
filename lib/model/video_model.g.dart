// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    id: json['ID'] as int,
    postTitle: json['post_title'] as String,
    video: json['video'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('post_title', instance.postTitle);
  writeNotNull('video', instance.video);
  writeNotNull('description', instance.description);
  return val;
}

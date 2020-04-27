import 'package:json_annotation/json_annotation.dart';
import 'package:covid/model/base_post_model.dart';

part 'video_model.g.dart';

/// Stats Model
@JsonSerializable(includeIfNull: false)
class VideoModel extends BasePostModel {
  /// Recovered total cases
  @JsonKey(name: 'post_title')
  final String postTitle;

  /// Confirmed total cases
  @JsonKey(name: 'video')
  final String video;

  /// Suspected total cases
  @JsonKey(name: 'description')
  final String description;

  String getVideoUrl() {
    var regex = RegExp(r'(?<=src=").*?(?=[?"])');
    var videoUrl = regex.firstMatch(video)?.group(0);
    return videoUrl?.replaceAll("\\", "");
  }

  String getVideoId() {
    var videoUrl = getVideoUrl();
    Uri uri = Uri.parse(videoUrl);
    return uri.pathSegments.last;
  }

  String getVideoThumbnail() {
    return "https://img.youtube.com/vi/${getVideoId()}/hqdefault.jpg";
  }

  /// Model constructor
  ///
  /// All properties are mandatory
  ///
  VideoModel({
    int id,
    this.postTitle,
    this.video,
    this.description,
  }) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}

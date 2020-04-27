import 'package:covid/model/video_model.dart';
import 'package:flutter/material.dart';

class VideosProvider extends ChangeNotifier {
  List<VideoModel> _video;

  List<VideoModel> get videos => _video;

  void setVideos(List<VideoModel> values) {
    _video = values;
    notifyListeners();
  }
}

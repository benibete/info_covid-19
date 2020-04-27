import 'package:flutter/material.dart';
import 'package:covid/model/detail_stats_model.dart';

class DetailStatsProvider extends ChangeNotifier {
  List<DetailStatsModel> _detailStats;

  List<DetailStatsModel> get detailStats => _detailStats;

  void setDetailStats(List<DetailStatsModel> values) {
    _detailStats = values;
    notifyListeners();
  }
}

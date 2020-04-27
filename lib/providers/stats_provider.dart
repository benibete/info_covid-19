import 'package:covid/model/stats_model.dart';
import 'package:flutter/material.dart';

/// Creates a Provider for updating UI
class StatsProvider extends ChangeNotifier {
  String _recovered = "0";
  String get recovered => _recovered;

  String _confirmed = "0";
  String get confirmed => _confirmed;

  String _suspected = "0";
  String get suspected => _suspected;

  String _awaitingResults = "0";
  String get awaitingResults => _awaitingResults;

  String _deaths = "0";
  String get deaths => _deaths;

  String _lastUpdated = "N/A";
  String get lastUpdated => _lastUpdated;

  setStats(StatsModel stats) {
    if (stats == null) {
      return;
    }
    _recovered = stats.recovered;
    _confirmed = stats.confirmed;
    _suspected = stats.suspected;
    _awaitingResults = stats.awaitingResults;
    _deaths = stats.deaths;
    _lastUpdated = stats.lastUpdated;
    notifyListeners();
  }
}

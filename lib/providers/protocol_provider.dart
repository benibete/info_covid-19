import 'package:flutter/material.dart';
import 'package:covid/model/protocol_model.dart';

class ProtocolProvider extends ChangeNotifier {
  List<ProtocolModel> _protocol;

  List<ProtocolModel> get protocol => _protocol;

  void setProtocol(List<ProtocolModel> values) {
    _protocol = values;
    notifyListeners();
  }
}

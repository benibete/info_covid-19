import 'package:covid/model/faq_model.dart';
import 'package:flutter/material.dart';

class FaqProvider extends ChangeNotifier {
  final Map<int, List<FaqModel>> _faqs = <int, List<FaqModel>>{};

  Map<int, List<FaqModel>> get faqs => _faqs;

  void setFaqs(Map<int, List<FaqModel>> values) {
    if (values == null) {
      return;
    }
    _faqs.clear();
    _faqs.addAll(values);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:covid/model/faq_category_model.dart';

class FaqCategoryProvider extends ChangeNotifier {
  List<FaqCategoryModel> _faqs;

  List<FaqCategoryModel> get faqs => _faqs;

  void setFaqsCategories(List<FaqCategoryModel> values) {
    _faqs = values;
    notifyListeners();
  }
}

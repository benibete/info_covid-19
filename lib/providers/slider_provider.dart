import 'package:covid/model/slider_model.dart';
import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {
  List<SliderModel> _slider;

  List<SliderModel> get slider => _slider;

  void setSlider(List<SliderModel> values) {
    if (values == null) {
      return;
    }
    _slider = values;

    /// Sort Slides by order
    _slider.sort((s1, s2) => s1.order.toInt().compareTo(s2.order.toInt()));

    notifyListeners();
  }
}

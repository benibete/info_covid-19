import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';

/// An indicator showing the currently selected page of a PageController
class CardHomeSliderIndicator extends AnimatedWidget {
  CardHomeSliderIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  /// The PageController for the indicator.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the indicator.
  final Color color;

  Widget _buildLineIndicator(int index) {
    /// Color to used for slides that are not visible
    var _color = Covid19Colors.grey;

    /// In case [controller] is not ready and page is still null
    /// then set the first indicator to be the [color]
    /// and the rest use [Covid19Colors.grey]
    ///
    /// When [controller] is ready and [index]
    /// is equal to the [controller.page] then set
    /// the [color] for the current index,
    /// rest will use the [Covid19Colors.grey]
    if ((controller.page == null && index == 0) ||
        (controller.page != null && index == controller.page.toInt())) {
      _color = color;
    }

    return Container(
      key: Key("Card-Home-Slider-$index"),
      width: 24,
      child: Center(
        child: Material(
          color: _color,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          type: MaterialType.canvas,
          child: Container(
            width: 14.0,
            height: 2.0,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 35.0),
      decoration: BoxDecoration(
        color: Covid19Colors.white.withAlpha(80),
        border: Border.all(
          color: Covid19Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, _buildLineIndicator),
      )
    );
  }
}

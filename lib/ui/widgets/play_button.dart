import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        height: 18.098360061645508,
        margin: EdgeInsets.only(
          left: 26.88525390625,
          right: 26.88525390625,
        ),
        decoration: BoxDecoration(
          color: Covid19Colors.green,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

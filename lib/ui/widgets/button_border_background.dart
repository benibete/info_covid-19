import 'package:flutter/material.dart';

class ButtonBorderBackground extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Widget child;

  const ButtonBorderBackground(
      {Key key, this.color, this.borderColor, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: child,
    );
  }
}

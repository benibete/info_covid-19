import 'package:flutter/material.dart';

class ButtonBackground extends StatelessWidget {
  final Color color;
  final Widget child;
  final double border;

  const ButtonBackground({
    Key key,
    this.color,
    this.child,
    this.border = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: color,
      ),
      padding: EdgeInsets.all(border),
      child: child,
    );
  }
}

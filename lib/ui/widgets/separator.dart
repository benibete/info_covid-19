import 'package:covid/ui/assets/dimensions.dart';
import 'package:flutter/material.dart';

import '../assets/colors.dart';

class Separator extends StatelessWidget {
  Separator({Key key, Color color})
      : _color = color ?? Covid19Colors.green,
        super(key: key);

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: _color,
      endIndent: identMargin,
      indent: identMargin,
      thickness: 2.0,
    );
  }
}

class ListSeparator extends StatelessWidget {
  ListSeparator({Key key, Color color})
      : _color = color ?? Covid19Colors.green,
        super(key: key);

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: _color,
      thickness: 2.0,
    );
  }
}

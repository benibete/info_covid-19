import 'package:covid/resources/icons_svg.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';
import 'button_border_background.dart';

class CardBorderArrow extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final VoidCallback callback;
  final Color color;

  const CardBorderArrow({
    Key key,
    @required this.text,
    @required this.callback,
    @required this.textColor,
    Color color,
    this.borderColor,
  })  : color = color ?? Covid19Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: ButtonBorderBackground(
        borderColor: borderColor ?? textColor,
        color: color,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .copyWith(color: textColor),
              ),
            ),
            SvgIcons.linkSvg(
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

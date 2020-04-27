import 'package:flutter/material.dart';
import 'package:covid/resources/icons_svg.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/widgets/button_background.dart';

class CardHome extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Color backgroundColor;
  final Color textColor;

  const CardHome({
    Key key,
    @required this.text,
    @required this.callback,
    Color backgroundColor,
    Color textColor,
  })  : backgroundColor = backgroundColor ?? Covid19Colors.lightGrey,
        textColor = textColor ?? Covid19Colors.darkGrey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: ButtonBackground(
        color: backgroundColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(color: textColor),
              ),
            ),
            SizedBox(width: 12.0),
            SvgIcons.linkSvg(
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/widgets/button_background.dart';
import 'package:covid/ui/widgets/statistics_border.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final Color color;
  final String number;
  final String text;
  final TextStyle numberStyle;
  final TextStyle textStyle;

  const StatsWidget(
      {Key key,
      this.color,
      this.number,
      this.text,
      this.numberStyle,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBackground(
      border: 0.0,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: StatisticsBorder(
              color: Covid19Colors.darkGrey,
              text: Text(
                number,
                style: numberStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

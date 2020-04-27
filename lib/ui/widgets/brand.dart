import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '#COVID19',
            style: TextStyle(
              color: Covid19Colors.red,
              fontSize: 24.0,
            ),
          ),
          TextSpan(
            text: 'PT',
            style: TextStyle(
              color: Covid19Colors.green,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}

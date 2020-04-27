import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardFilesLink extends StatelessWidget {
  final String text;
  final String link;

  CardFilesLink(this.text, this.link);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl(link);
      },
      child: Card(
        color: Covid19Colors.green,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Covid19Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Covid19Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchUrl(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Cannot launch $link';
    }
  }
}

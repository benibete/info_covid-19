import 'package:covid/utils/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlContent extends StatelessWidget {
  final String content;

  const HtmlContent({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      backgroundColor: Colors.white,
      onLinkTap: launchURL,
      defaultTextStyle: Theme.of(context).textTheme.body1,
      linkStyle: Theme.of(context)
          .textTheme
          .body1
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }
}

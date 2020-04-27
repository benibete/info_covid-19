import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/screens/home/components/accordion.dart';
import 'package:covid/utils/launch_url.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

class InitiativesItem extends StatelessWidget {
  final String title;
  final String body;
  final Function(bool) onExpansionChanged;

  const InitiativesItem(
      {Key key, this.title, this.body, this.onExpansionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      key: key,
      withBorder: false,
      title: title,
      contentPadding: const EdgeInsets.only(left: 12, right: 17),
      padding: const EdgeInsets.all(0.0),
      margin: const EdgeInsets.all(0.0),
      childrenPadding: const EdgeInsets.only(left: 12, right: 12),
      titleTextStyle: Theme.of(context)
          .textTheme
          .display3
          .copyWith(color: Covid19Colors.green),
      onExpansionChanged: onExpansionChanged,
      children: <Widget>[
        Html(
            useRichText: true,
            data: body.replaceAll("\\n", ""),
            backgroundColor: Colors.white,
            defaultTextStyle: Theme.of(context).textTheme.body1,
            onLinkTap: launchURL,
            linkStyle: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).primaryColor),
            customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "custom_tag":
                    return Column(children: children);
                }
              }
              return null;
            })
      ],
    );
  }
}

import 'package:covid/generated/l10n.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/widgets/card_border_arrow.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Covid19Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Covid19Colors.white,
              ),
          backgroundColor: Covid19Colors.blue,
          title: Text(
            S.of(context).screenAboutTitle.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Covid19Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    S.of(context).screenAboutContent1,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Covid19Colors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutContent2,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Covid19Colors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutContent3,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Covid19Colors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutContent4,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Covid19Colors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  /*
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutContent5,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Covid19Colors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  */
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutHashtag,
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Covid19Colors.darkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  const _TextMargin(),
                  /*
                  const _TextMargin(),
                  Text(
                    S.of(context).screenAboutBuilt,
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Covid19Colors.darkGrey,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  CardBorderArrow(
                    text: S.of(context).screenAboutButtonReport,
                    callback: () => print("yey"),
                    textColor: Covid19Colors.darkGrey,
                    borderColor: Covid19Colors.grey,
                  ),
                  */
                  const _FooterMargin(),
                  CardBorderArrow(
                    text: S.of(context).screenAboutButtonOpenSource,
                    callback: () =>
                        Navigator.of(context).pushNamed(routeLicences),
                    textColor: Covid19Colors.darkGrey,
                    borderColor: Covid19Colors.grey,
                  ),
                ],
              ),
            ),
            Container(
              color: Covid19Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      S.of(context).screenAboutFooter1,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Covid19Colors.darkGrey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      S.of(context).screenAboutFooter2,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Covid19Colors.darkGrey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const _FooterMargin(),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class _TextMargin extends StatelessWidget {
  const _TextMargin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8.0,
    );
  }
}

class _FooterMargin extends StatelessWidget {
  const _FooterMargin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 18.0,
    );
  }
}

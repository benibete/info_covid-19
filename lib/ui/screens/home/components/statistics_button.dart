import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:covid/resources/icons_svg.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/widgets/button_background.dart';
import 'package:covid/ui/screens/statistics/components/stats_widget.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsButton extends StatelessWidget {
  final VoidCallback callback;

  const StatisticsButton({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Covid19Colors.green50),
      child: InkWell(
        onTap: callback,
        child: ButtonBackground(
          color: Covid19Colors.red,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      S.of(context).homePageConfirmedCases.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 120,
                child: StatsWidget(
                  color: Covid19Colors.statsBlue,
                  number: Provider.of<StatsProvider>(context).confirmed,
                  numberStyle:
                      TextStyles.statisticsBig(color: Covid19Colors.darkGrey),
                  text: S.of(context).statisticsPageConfirmed.toUpperCase(),
                  textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: Covid19Colors.darkGrey),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: StatsWidget(
                        color: Covid19Colors.statsGreen,
                        number: Provider.of<StatsProvider>(context).recovered,
                        numberStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Covid19Colors.darkGrey),
                        text: S.of(context).statisticsPageRecovered.toUpperCase(),
                        textStyle: Theme.of(context)
                            .textTheme
                            .display4
                            .copyWith(color: Covid19Colors.darkGrey),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: StatsWidget(
                        color: Covid19Colors.statsRed,
                        number: Provider.of<StatsProvider>(context).deaths,
                        numberStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Covid19Colors.darkGrey),
                        text: S.of(context).statisticsPageDeath.toUpperCase(),
                        textStyle: Theme.of(context)
                            .textTheme
                            .display4
                            .copyWith(color: Covid19Colors.darkGrey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    S.of(context).checkDetails,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  SvgIcons.linkSvg(
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

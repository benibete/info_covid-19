import 'package:covid/bloc/app_bloc.dart';
import 'package:covid/bloc/base_bloc.dart';
import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/detail_stats_provider.dart';
import 'package:covid/model/detail_stats_model.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:covid/ui/screens/statistics/components/stats_widget.dart';
import 'package:covid/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const _itemsMargin = 8.0;

class StatisticsPage extends BasePage {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends BaseState<StatisticsPage, AppBloc> {
  List<DetailStatsModel> _detailStats = [];
  final ScrollController scrollController = ScrollController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    bloc.getDetailStats();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
    {
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    _detailStats = Provider.of<DetailStatsProvider>(context).detailStats ??
        ModalRoute.of(context).settings.arguments;

    var hasData = _detailStats != null && _detailStats.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          S.of(context).statisticsPageStatistics.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .display2
              .copyWith(color: Covid19Colors.white),
        ),
        backgroundColor: Covid19Colors.blue,
        elevation: 0.0,
      ),
      body: hasData ?
        Scrollbar(
        child: Container(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            header: WaterDropMaterialHeader(
              backgroundColor: Covid19Colors.blue,
            ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              itemCount: _detailStats.length,
              itemBuilder: (context, index) {
                return ExpandableNotifier(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Card(
                      color: Covid19Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          ScrollOnExpand(
                            scrollOnExpand: true,
                            scrollOnCollapse: false,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment: ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                                iconColor: Covid19Colors.green,
                              ),
                              header: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  _detailStats[index].province.toUpperCase(),
                                  style: Theme.of(context).textTheme.display3.copyWith(
                                    color: Covid19Colors.green, letterSpacing: 0.2
                                  ),
                                )
                              ),
                              expanded: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    height: 130,
                                    child: StatsWidget(
                                      color: Covid19Colors.statsBlue,
                                      number: _detailStats[index].positiveCase,
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
                                    height: _itemsMargin,
                                  ),
                                  Container(
                                    height: 90,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: StatsWidget(
                                            color: Covid19Colors.statsGreen,
                                            number: _detailStats[index].recoveredCase,
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
                                          width: _itemsMargin,
                                        ),
                                        Expanded(
                                          child: StatsWidget(
                                            color: Covid19Colors.statsRed,
                                            number: _detailStats[index].deathCase,
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
                                    height: _itemsMargin,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                        "${S.of(context).lastUpdated.toUpperCase()}${_detailStats[index].lastUpdated}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(color: Covid19Colors.grey)),
                                  ),
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(crossFadePoint: 0),
                                  ),
                                );
                              },
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                );
              }
            )
          ),
        )
      )
      : const Loading(),
    );
  }

  @override
  void initBloc(AppBloc bloc) {
    var provider = Provider.of<DetailStatsProvider>(context);

    if (_detailStats == null ||
        provider.detailStats == null ||
        (provider.detailStats != null && provider.detailStats.isEmpty)) {
      bloc.getDetailStats();
    }
  }

  @override
  Stream<ResultStream> get onStateListener => bloc.onListener;

  @override
  void onStateResultListener(ResultStream result) {
    if (result is DetailStatsResultStream) {
      /// Updates faqs list on the provider
      Provider.of<DetailStatsProvider>(context, listen: false)
          .setDetailStats(result.model);

      /// Updates videos list
      _detailStats = result.model;
    }
  }
}

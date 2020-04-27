import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:covid/providers/slider_provider.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/screens/home/components/card_home_slider.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:covid/ui/screens/home/components/card_home.dart';
import 'package:covid/ui/widgets/card_border_arrow.dart';
import 'package:covid/ui/screens/home/components/silver_bar.dart';
import 'package:covid/bloc/app_bloc.dart';
import 'package:covid/bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../app.dart';
import 'components/statistics_button.dart';

/// Creates an HomePage extending [BasePage]
/// that is a StatefulWidget
class HomePage extends BasePage {
  /// Home page view
  HomePage({Key key, this.title}) : super(key: key);

  /// Title of the page view
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, AppBloc> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    initBloc(bloc);
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
  void initBloc(AppBloc bloc) {
    bloc.getStats();
    bloc.getSlider();
  }

  @override
  Stream<ResultStream> get onStateListener => bloc.onListener;

  @override
  void onStateResultListener(ResultStream result) {
    if (result is StatsResultStream) {
      Provider.of<StatsProvider>(context, listen: false).setStats(result.model);
    }

    if (result is SliderResultStream) {
      Provider.of<SliderProvider>(context, listen: false).setSlider(result.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    var stats = Provider.of<StatsProvider>(context);
    logger.i('[StatsProvider] $stats! - ${stats.hashCode}');

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: WaterDropMaterialHeader(
          backgroundColor: Covid19Colors.red,
        ),
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              leading: Container(),
              backgroundColor: Covid19Colors.blue,
              elevation: 0.0,
              centerTitle: true,
              expandedHeight: 100.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  S.of(context).homePageTitle.toUpperCase(),
                  style: TextStyles.subtitle(
                    color: Covid19Colors.white,
                  )
                ),
                background: Image.asset("assets/welcome_1.png",
                  width: double.infinity,
                  height: 150.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                  DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/welcome_2.png"),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: <Widget>[
                          HomeSlider()
                        ],
                      ),
                    ),
                  ),
                  140.0
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: <Widget>[
                          StatisticsButton(
                            callback: () =>
                                Navigator.of(context).pushNamed(routeStatistics),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardHome(
                            text: S.of(context).protocolPageTitle.toUpperCase(),
                            callback: () =>
                                Navigator.of(context).pushNamed(routeProtocol),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardHome(
                            text: S.of(context).faqPageTitle.toUpperCase(),
                            callback: () =>
                                Navigator.of(context).pushNamed(routeFaqs),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardHome(
                            text: S.of(context).screenVideosTitle.toUpperCase(),
                            callback: () =>
                                Navigator.of(context).pushNamed(routeVideos),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardHome(
                            text: S.of(context).contactsPageTitle,
                            callback: () =>
                                Navigator.of(context).pushNamed(routeContacts),
                            backgroundColor: Covid19Colors.blue,
                            textColor: Covid19Colors.white,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardBorderArrow(
                            text: S
                                .of(context)
                                .screenNotificationsTitle
                                .toUpperCase(),
                            callback: () => Navigator.of(context)
                                .pushNamed(routeNotifications),
                            textColor: Covid19Colors.darkGrey,
                            borderColor: Covid19Colors.lightGrey,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CardBorderArrow(
                            text: S.of(context).screenAboutTitle.toUpperCase(),
                            callback: () =>
                                Navigator.of(context).pushNamed(routeAbout),
                            textColor: Covid19Colors.darkGrey,
                            borderColor: Covid19Colors.lightGrey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]
                ),
              ),
            )
          ]
        )
      ),
    );
  }
}

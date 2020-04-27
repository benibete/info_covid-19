import 'dart:async';
import 'dart:math';

import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/faq_category_provider.dart';
import 'package:covid/providers/faq_provider.dart';
import 'package:covid/providers/slider_provider.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:covid/providers/videos_provider.dart';
import 'package:covid/providers/detail_stats_provider.dart';
import 'package:covid/providers/protocol_provider.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/resources/icons_svg.dart';
import 'package:covid/ui/app.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/assets/images.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:covid/ui/screens/splash/components/animated_wawe.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/app_bloc.dart';
import '../../../bloc/base_bloc.dart';

/// Creates an HomePage extending [BasePage]
/// that is a StatefulWidget
class SplashPage extends BasePage {
  /// Home page view
  SplashPage({Key key, this.title}) : super(key: key);

  /// Title of the page view
  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc> {
  final PublishSubject _statsSubject = PublishSubject<bool>();
  final PublishSubject _sliderSubject = PublishSubject<bool>();
  final PublishSubject _animationComplete = PublishSubject<bool>();

  Stream<bool> get _dataLoaded => Rx.combineLatest2(
              _animationComplete,
              Rx.zip2(_statsSubject, _sliderSubject, (stats, slider) {
                logger.i("_statsSubject : $stats");
                logger.i("_sliderSubject : $slider");
                logger.d("COMBINED: ${stats && slider}");
                return stats && slider;
              }),
              (animation, api) => animation && api)
          .timeout(Duration(seconds: 5), onTimeout: (sink) {
        sink.add(true);
      });

  StreamSubscription<bool> _dataLoadedSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _dataLoadedSubscription = _dataLoaded.listen((loaded) async {
        logger.d("NEW DATA: $loaded");
        if (loaded) {
          logger.i("I'm inside the LOADED part");
          _dataLoadedSubscription.cancel();
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(routeHome, (_) => false)
              .catchError(logger.e);
          logger.i("After the navigation");
        } else {
          logger.e("NO DATA");
          _insertOverlay(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /*
          Center(
            child: Image.asset(
              logoInfoCovid,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          */
          FlareActor(
            "assets/info_covid.flr",
            alignment: Alignment.center,
            animation: "in",
            callback: (status) {
              _animationComplete.add(true);
            },
          ),
          onBottom(AnimatedWave(
            height: 130,
            speed: 1.0,
          )),
          onBottom(AnimatedWave(
            height: 70,
            speed: 0.9,
            offset: pi,
          )),
          onBottom(AnimatedWave(
            height: 170,
            speed: 1.2,
            offset: pi / 2,
          )),
        ]
      )
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );

  @override
  void initBloc(SplashBloc bloc) {
    /// Get Case Stats
    ///
    bloc.bloc.getStats();

    /// Get Slider
    ///
    bloc.bloc.getSlider();

    scheduleMicrotask(() {
      /// Get Faq Posts
      ///
      bloc.bloc.getFaqCategories();

      /// Get Videos Posts
      ///
      bloc.bloc.getVideos();

      /// Get Detail Stats
      ///
      bloc.bloc.getDetailStats();

      /// Get Detail Protocol
      ///
      bloc.bloc.getProtocol();
    });
  }

  @override
  Stream<ResultStream> get onStateListener => bloc.bloc.onListener;

  @override
  void onStateResultListener(ResultStream result) {
    if (result is StatsResultStream) {
      Provider.of<StatsProvider>(context, listen: false).setStats(result.model);

      if (result.state == StateStream.success) {
        _statsSubject.add(true);
      } else if (result.state == StateStream.fail) {
        _statsSubject.add(false);
      }
    }

    if (result is FaqCategoryResultStream) {
      Provider.of<FaqCategoryProvider>(context, listen: false)
          .setFaqsCategories(result.model);
    }

    if (result is VideosResultStream) {
      Provider.of<VideosProvider>(context, listen: false)
          .setVideos(result.model);
    }

    if (result is SliderResultStream) {
      Provider.of<SliderProvider>(context, listen: false)
          .setSlider(result.model);

      if (result.state == StateStream.success) {
        _sliderSubject.add(true);
      } else if (result.state == StateStream.fail) {
        _sliderSubject.add(false);
      }
    }

    if (result is FaqResultStream) {
      Provider.of<FaqProvider>(context, listen: false).setFaqs(result.model);
    }

    if (result is DetailStatsResultStream) {
      Provider.of<DetailStatsProvider>(context, listen: false)
          .setDetailStats(result.model);
    }

    if (result is ProtocolResultStream) {
      Provider.of<ProtocolProvider>(context, listen: false)
          .setProtocol(result.model);
    }
  }

  void _insertOverlay(BuildContext context) {
    logger.e("Called insert overlay");
    var entry;
    entry = OverlayEntry(
        opaque: false,
        builder: (context) {
          return Material(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  margin: EdgeInsets.all(24.0),
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(S.of(context).noConnection,
                          style: Theme.of(context).textTheme.display2.copyWith(
                                color: Covid19Colors.darkGrey,
                              )),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Image.asset(
                        connectionError,
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        S.of(context).cannotConnectInternetDescription,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          entry.remove();
                          initBloc(bloc);
                        },
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              S.of(context).buttonTryAgain,
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            SvgIcons.linkSvg(color: Colors.white)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    return Overlay.of(context).insert(
      entry,
    );
  }

  @override
  void dispose() {
    logger.i("Dispose called");
    _statsSubject.close();
    _sliderSubject.close();
    if (_dataLoadedSubscription != null) {
      _dataLoadedSubscription.cancel();
    }
    super.dispose();
  }
}

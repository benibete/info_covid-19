import 'dart:io';

import 'package:covid/bloc/app_bloc.dart';
import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/faq_category_provider.dart';
import 'package:covid/providers/faq_provider.dart';
import 'package:covid/providers/notifications_provider.dart';
import 'package:covid/providers/slider_provider.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:covid/providers/videos_provider.dart';
import 'package:covid/providers/detail_stats_provider.dart';
import 'package:covid/providers/protocol_provider.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/resources/custom_localization.dart';
import 'package:covid/resources/style/themes.dart';
import 'package:covid/ui/screens/about/about_page.dart';
import 'package:covid/ui/screens/contacts/contacts_page.dart';
import 'package:covid/ui/screens/faqs/faqs_page.dart';
import 'package:covid/ui/screens/faqs_details/faq_details_page.dart';
import 'package:covid/ui/screens/home/home_page.dart';
import 'package:covid/ui/screens/notifications/notifications_page.dart';
import 'package:covid/ui/screens/protocol/protocol_document.dart';
import 'package:covid/ui/screens/splash/splash_page.dart';
import 'package:covid/ui/screens/statistics/statistics_page.dart';
import 'package:covid/ui/screens/video_player/video_player_page.dart';
import 'package:covid/ui/screens/videos/videos_page.dart';
import 'package:covid/ui/screens/protocol/protocol_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

/// Used to log all the events happening
final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));

/// Starting class for the project
class CovidApp extends StatelessWidget {
  final AppBloc appBloc = AppBloc();
  final statsProvider = StatsProvider();
  final faqProvider = FaqProvider();
  final videosProvider = VideosProvider();
  final notificationsProvider = NotificationsProvider();
  final sliderProvider = SliderProvider();
  final faqsCategoryProvider = FaqCategoryProvider();
  final detailStatsProvider = DetailStatsProvider();
  final protocolProvider = ProtocolProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    String appVersion = '';

    /// If is an Android then change the status bar color
    /// to dark and text to white
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.light
          ));
    }

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion = packageInfo.version + '+' + packageInfo.buildNumber;
    });

    return MultiProvider(
      providers: [
        Provider<AppBloc>.value(value: appBloc),
        ProxyProvider<AppBloc, SplashBloc>(
          update: (_, __, splashBloc) => SplashBloc(appBloc),
        ),
        ChangeNotifierProvider<StatsProvider>.value(value: statsProvider),
        ChangeNotifierProvider<FaqProvider>.value(value: faqProvider),
        ChangeNotifierProvider<VideosProvider>.value(
          value: videosProvider,
        ),
        ChangeNotifierProvider<NotificationsProvider>.value(
          value: notificationsProvider,
        ),
        ChangeNotifierProvider<SliderProvider>.value(
          value: sliderProvider,
        ),
        ChangeNotifierProvider<FaqCategoryProvider>.value(
          value: faqsCategoryProvider,
        ),
        ChangeNotifierProvider<DetailStatsProvider>.value(
          value: detailStatsProvider,
        ),
        ChangeNotifierProvider<ProtocolProvider>.value(
          value: protocolProvider,
        ),
      ],
      child: MaterialApp(
        title: 'Info Covid-19',
        localizationsDelegates: [
          S.delegate,
          LicensesPageTitleTextLocalDelegate(context),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: Themes.defaultAppTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: routeSplash,
        onGenerateRoute: (settings) {
          var page;
          switch (settings.name) {
            case routeSplash:
              page = SplashPage();
              break;
            case routeHome:
              page = HomePage(title: 'Info Covid-19');
              break;
            case routeStatistics:
              page = StatisticsPage();
              break;
            case routeContacts:
              page = ContactsPage();
              break;
            case routeProtocol:
              page = ProtocolPage(title: 'Protokol');
              break;
            case routeProtocolDocument:
              page = ProtocolDocumentPage(url: settings.arguments);
              break;
            case routeFaqs:
              page = FaqsPage(title: 'Tanya Jawab');
              break;
            case routeFaqsDetails:
              page = FaqsDetails(title: 'Tanya Jawab', faqs: settings.arguments);
              break;
            case routeVideos:
              page = VideosPage(title: 'Video');
              break;
            case routeAbout:
              page = AboutPage();
              break;
            case routeVideoPlayer:
              page = VideoPlayerPage();
              break;
            case routeNotifications:
              page = NotificationsPage();
              break;
            case routeLicences:
              page = LicensePage(
                applicationName: 'Info Covid-19',
                applicationVersion: appVersion,
                applicationIcon: Image.asset("assets/icons/icon_small.png", height: 100, width: 100,),
              );
              break;
          }
          return CupertinoPageRoute(builder: (_) => page, settings: settings);
        },
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:covid/services/messaging_service.dart';
import 'package:covid/ui/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

AppConfig appConfig;

void main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  /// Override automaticSystemUiAdjustment auto UI color overlay adjustment
  /// on Android
  if (Platform.isAndroid) {
    binding.renderView.automaticSystemUiAdjustment = false;
  }

  var enableInDevMode = true;

  /// Set `enableInDevMode` to true to see reports while in debug mode
  /// This is only to be used for confirming that reports are being
  /// submitted as expected. It is not intended to be used for everyday
  /// development.
  Crashlytics.instance.enableInDevMode = enableInDevMode;

  /// Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  appConfig = AppConfig.prod;

  /// Init Firebase messaging service
  await MessagingService.init();

  runZoned<Future<void>>(() async {
    /// Run main app
    runApp(CovidApp());
  }, onError: (e, s) {
    /// Register and sends error
    Crashlytics.instance.recordError(e, s);

    /// for debug:
    if (enableInDevMode) {
      logger.e('[Error]: ${e.toString()}');
      logger.e('[Stacktrace]: ${s.toString()}');
    }
  });
}

enum AppConfig {
  dev,
  prod,
}
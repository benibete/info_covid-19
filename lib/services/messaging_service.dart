import 'dart:io';

import 'package:covid/resources/constants.dart';
import 'package:covid/ui/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_permissions/notification_permissions.dart';

abstract class MessagingService {
  MessagingService._();
  static final String _tag = '$bundle.PushNotificationsService';
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static bool notificationsEnabledForApp = false;

  static Future<bool> init({bool force = false}) async {
    logger.i("$_tag: Initing FCM service...");

    PermissionStatus permissionStatus =
        await NotificationPermissions.getNotificationPermissionStatus();

    bool permissionsAllowed = true;

    if (permissionStatus == PermissionStatus.unknown &&
        !await _firebaseMessaging.requestNotificationPermissions()) {
      permissionsAllowed = false;
    } else if (permissionStatus == PermissionStatus.denied) {
      permissionsAllowed = false;
    }

    if (!permissionsAllowed) {
      notificationsEnabledForApp = null;
      logger.w(
          "$_tag: Device has not given notifications permissions for this app.");
      return false;
    }

    logger.i("$_tag: Device has notifications on for this app.");
    _configureFCMHandlers();
    return notificationsEnabledForApp = true;
  }

  static void _configureFCMHandlers() async {
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      logger.i("$_tag: Push notifications registered for iOS: $settings");
    });

    _firebaseMessaging.getToken().then((token) {
      logger.i('$_tag: Device registered for FCM with token: $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        logger.i("$_tag Push (onMessage): $message");
      },
      onBackgroundMessage:
          Platform.isIOS ? null : _backgroundNotificationsHandler,
      onLaunch: (Map<String, dynamic> message) async {
        logger.i(_tag, "$_tag: Push (onLaunch): $message");
      },
      onResume: (Map<String, dynamic> message) async {
        logger.i("$_tag: Push (onResume): $message");
      },
    );
  }

  static Future<bool> unregister() async {
    if (await _firebaseMessaging.deleteInstanceID()) {
      logger.i("$_tag: FCM disabled for current device with success.");
      return true;
    }
    logger.w("$_tag: Could not disable FCM for current device.");
    return false;
  }

  static Future<dynamic> _backgroundNotificationsHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // final dynamic data = message['data'];
      logger.i("$_tag: Push (background) data message: $message");
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      logger.i(_tag, "$_tag: Push (background) data message: $notification");
    }
    return null;
  }
}
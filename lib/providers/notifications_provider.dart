import 'package:covid/model/notifications_model.dart';
import 'package:covid/services/messaging_service.dart';
import 'package:flutter/material.dart';

enum Channel {
  general,
  stats,
  measures,
  questions,
  other,
}

class NotificationsProvider extends ChangeNotifier {
  NotificationsModel notifications = NotificationsModel();

  void checkInitialStatus() {
    notifications = NotificationsModel(
        general: MessagingService.notificationsEnabledForApp);
  }

  void checkPermissions() async {
    await MessagingService.init();
    notifications = NotificationsModel(
        general: MessagingService.notificationsEnabledForApp);
    notifyListeners();
  }

  void toggleNotification({@required Channel channel, bool value = false}) {
    switch (channel) {
      case Channel.general:
        value ? MessagingService.init() : MessagingService.unregister();
        notifications = notifications.copyWith(general: value);
        break;
      case Channel.stats:
        notifications = notifications.copyWith(stats: value);
        break;
      case Channel.measures:
        notifications = notifications.copyWith(measures: value);
        break;
      case Channel.questions:
        notifications = notifications.copyWith(questions: value);
        break;
      case Channel.other:
        notifications = notifications.copyWith(other: value);
        break;
      default:
    }

    notifyListeners();
  }
}

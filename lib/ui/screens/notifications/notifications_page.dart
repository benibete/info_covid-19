import 'package:covid/generated/l10n.dart';
import 'package:covid/providers/notifications_provider.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_settings/app_settings.dart';

class NotificationsPage extends BasePage {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with WidgetsBindingObserver {
  Widget _buildToggleOption(
    BuildContext context, {
    String text,
    Function(bool) onChanged,
    bool value = false,
    bool withBorder = false,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          border: withBorder ? Border.all(color: Colors.black12) : null,
        ),
        child: ListTile(
          title: Text(
            text.toUpperCase(),
            style: TextStyles.h4(),
          ),
          trailing: Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<NotificationsProvider>(context, listen: false)
        .checkInitialStatus();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<NotificationsProvider>(context, listen: false)
            .checkPermissions();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          S.of(context).screenNotificationsTitle.toUpperCase(),
          style: TextStyles.h2(color: Covid19Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
        child: Consumer<NotificationsProvider>(
          builder: (BuildContext context, NotificationsProvider provider, _) =>
              Column(
            children: <Widget>[
              Text(S.of(context).notificationsPageDescription),
              const SizedBox(height: 40.0),
              _buildToggleOption(
                context,
                value: provider.notifications.general ?? false,
                text: S.of(context).notificationsPageReceiveNotifcations,
                onChanged: provider.notifications.general != null
                    ? (value) => provider.toggleNotification(
                        channel: Channel.general, value: value)
                    : null,
                withBorder: true,
              ),
              if (provider.notifications.general == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        S.of(context).notificationsPagePermissionsMissing,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .apply(color: Colors.deepOrange),
                      ),
                      CupertinoButton(
                        child: Text(
                          S.of(context).notificationsPageOpenSettings,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        onPressed: AppSettings.openNotificationSettings,
                      ),
                    ],
                  ),
                )
              //TODO: Uncomment when new options are available
              // _buildToggleOption(
              //   context,
              //   text: S.of(context).notificationsPageReceiveStats,
              //   value: false,
              // ),
              // _buildToggleOption(
              //   context,
              //   text: S.of(context).notificationsPageReceiveMeasures,
              //   value: false,
              // ),
              // _buildToggleOption(
              //   context,
              //   text: S.of(context).notificationsPageReceiveQuestions,
              //   value: false,
              // ),
              // _buildToggleOption(
              //   context,
              //   text: S.of(context).notificationsPageReceiveOther,
              //   value: false,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

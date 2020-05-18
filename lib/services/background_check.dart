import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newsfeed/helpers/date_helper.dart';
import 'package:newsfeed/helpers/preferences_helper.dart';
import 'package:newsfeed/pages/dashboard/dashboard_page.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:uuid/uuid.dart';

class BackgroundCheck {
  final newsFeedState = NewsFeedState();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext context;

  static BackgroundCheck _backgroundCheck;

  static BackgroundCheck getInstance() {
    if (_backgroundCheck == null) {
      _backgroundCheck = BackgroundCheck();
    }
    return _backgroundCheck;
  }

  BackgroundCheck() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<void> initPlatformState() async {
    int minimumInterval = await StorageHelper.getSelectedDuration();
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: minimumInterval == null
                ? 15
                : minimumInterval,
            stopOnTerminate: false,
            enableHeadless: true,
            startOnBoot: true), () async {
      checkUpdate();
    }).then((int status) {
      print('[BackgroundFetch] SUCCESS: $status');
    }).catchError((e) {
      print('[BackgroundFetch] ERROR: $e');
    });
  }

  void checkUpdate() async {
    var sendNotification = false;
    await newsFeedState.getNewsFeeds();
    final newsDate = await StorageHelper.getLastNewsDate();
    for (var item in newsFeedState.rssItemList) {
      if (isAfterDate(item.pubDate, newsDate)) {
        sendNotification = true;
        await StorageHelper.setLastNewsDate(item.pubDate);
      }
    }
    if (sendNotification) {
      _sendNotification();
    }
  }

  void _sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        Uuid().v1(), 'UpdatedNews', 'An unread news feeds',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(2006, 'Updated news',
        'There are some news for you', platformChannelSpecifics);
  }

  Future _onSelectNotification(String payload) async {
    await navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => DashboardPage()));
  }
}

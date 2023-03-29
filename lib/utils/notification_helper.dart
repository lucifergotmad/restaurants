import "dart:math";

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurants/data/api/response/restaurant_response.dart';
import 'package:restaurants/shared/navigation.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final _random = Random();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('notification');

    var initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        selectNotificationSubject.add(response.payload ?? "Empty Payload");
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResponse restaurantResponse) async {
    const channelId = "1";
    const channelName = "CHANNEL_01";
    const channelDescription = "Restaurant Channel Notification";

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final restaurant = restaurantResponse
        .restaurants[_random.nextInt(restaurantResponse.count)];

    await flutterLocalNotificationsPlugin.show(
      0,
      restaurant.name,
      restaurant.description,
      platformChannelSpecifics,
      payload: restaurant.id,
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        Navigation.intentWithData(route, payload);
      },
    );
  }
}

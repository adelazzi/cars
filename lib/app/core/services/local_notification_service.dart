import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final localNotification = FlutterLocalNotificationsPlugin();

  static void initialize() {
    localNotification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );
  }

  static void showNotification(
      {required String? title, required String? body}) {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'FreshDz',
      'FreshDz',
      channelDescription: 'FreshDz channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    localNotification.show(1, title, body, platformChannelSpecifics);
  }
}
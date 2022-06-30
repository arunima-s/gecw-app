import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id',
        'channel NAME'
        // , 'CHANNEL DESCRIPTION'
        ,
        priority: Priority.high,
        importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }
}

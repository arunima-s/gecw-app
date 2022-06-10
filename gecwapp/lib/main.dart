import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Screens/homeScreen.dart';
import 'package:gecwapp/screens/hostelListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }

  Future<void> initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            // iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  Future onSelectNotification(String? payload) async {
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return new AlertDialog(
    //       title: Text("PayLoad"),
    //       content: Text("Payload : $payload"),
    //     );
    //   },
    // );
  }
}

// class MyApp extends StatelessWidget {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   @override
//   Widget build(BuildContext context) {
//     initNotifications();
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }

//   void initNotifications() {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //   requestSoundPermission: false,
//     //   requestBadgePermission: false,
//     //   requestAlertPermission: false,
//     //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     // );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       // iOS: initializationSettingsIOS,
//       // macOS: null
//     );
//     flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) async {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return new AlertDialog(
//           title: Text("PayLoad"),
//           content: Text("Payload : $payload"),
//         );
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("Hello"),
//     );
//   }
// }

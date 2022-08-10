// @dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Constants/values.dart';
import 'package:gecwapp/Managers/cloud-message-manager.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/homeScreen.dart';
import 'package:gecwapp/screens/LoginScreens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'Providers/custom-ads-provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => HostelProvider()),
      ChangeNotifierProvider(create: (_) => SharedPrefsProvider()),
      ChangeNotifierProvider(create: (_) => CalendarDataProvider()),
      ChangeNotifierProvider(create: (_) => GWValuesProvider()),
      ChangeNotifierProvider(create: (_) => AdsProvider())
    ],
    child: RestartWidget(child: MyApp()),
  ));
  // runApp(MyApp());
}

////////////
//////////
///////////Restasrt widget

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

//////////
/////////
////End restart widget

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var isLoggedIn = false;
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    super.initState();
    initFirebase();

    // initCM();
    loadPrefs();
    initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    // GWValues().setHeight(screenHeight);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }

  ///////
  /////
  Future initFirebase() async {
    try {
      await Firebase.initializeApp().whenComplete(() {
        initCM();
      });
    } catch (e) {
      print("!!!!!!!!!!!!!!!!$e!!!!!!!!!!!!!!!");
    }
  }

  //
  ///Shared prefs
  void loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _isLoggedIn = prefs.getBool(SharedKeys.loginStatus);
    setState(() {
      isLoggedIn = _isLoggedIn ?? false;
    });
  }

  //
  ///////////Local Notifications
  ///
  void initNotifications() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
    print("88888888888888888888Notification tapperd");
  }

  /////////
  ///////Cloud messaging
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification.body}');
  }

  ///
  ///
  ///

  initCM() async {
    try {
      final firebaseMessaging = await FCM();
      await firebaseMessaging.setNotifications();

      firebaseMessaging.streamCtlr.stream.listen(_changeData);
      firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
      firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
      await FirebaseMessaging.instance.subscribeToTopic('weather');
    } catch (e) {
      print("!!!!!!!!!!!!!!!!!$e!!!!!!!!!!!!!!!!!!");
    }
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
}

  //////////////
  ///////////


// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/homeScreen.dart';
import 'package:gecwapp/screens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => HostelProvider()),
      ChangeNotifierProvider(create: (_) => SharedPrefsProvider()),
      ChangeNotifierProvider(create: (_) => CalendarDataProvider())
    ],
    child: MyApp(),
  ));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var isLoggedIn = false;

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
    return MaterialApp(
      // home: HomeScreen(),
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }

  ///////
  /////
  Future initFirebase() async {
    await Firebase.initializeApp().whenComplete(() {
      initCM();
    });
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
  }

  /////////
  ///////Cloud messaging
  ///
  initCM() async {
    FirebaseMessaging messaging = await FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("///////////////////////////////////$value/////////////////////");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  //////////////
  ///////////

}

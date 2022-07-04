import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Models/calendarEventModel.dart';
import 'package:gecwapp/Models/calendar_datamodel.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class CalendarScreen extends StatelessWidget {
  // const CalendarScreen({Key? key}) : super(key: key);
  List<CalendarDataModel> notificationsList = [];
  var flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    print('-----------------Calendar Screen--------------');
    notificationsList = context.watch<CalendarDataProvider>().notifications;
    if (notificationsList.isEmpty) {
      context.read<CalendarDataProvider>().getNotifications();
      // showNotification(1, 'title', 'body');
      // showNotification();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // showNotification();
      setLocalNotification();
      print('finished');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        showNavigationArrow: true,
        dataSource: MeetingDataSource(getDataSource()),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        onTap: (CalendarTapDetails details) {
          // showNotification();
          List<dynamic>? appointments = details.appointments;
          DateTime date = details.date!;
          CalendarElement element = details.targetElement;

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Container(
                      child: new Text(DateFormat('yyyy-MM-dd').format(date))),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                        itemCount: appointments?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // height: 80,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      appointments?[index].eventName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Text('000000000'),
                                //   ],
                                // ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        DateFormat('hh: mm: ss')
                                            .format(appointments?[index].from)
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text('close'))
                  ],
                );
              });
        },
      ),
    );
  }

  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    notificationsList.map((e) {
      meetings.add(Meeting(e.title, DateTime.parse(e.date), endTime,
          const Color(0xFF0F8644), false));
    }).toList();
    return meetings;
  }

  void setLocalNotification() {
    notificationsList.map((e) {
      scheduleNotification(
          5, 'Reminder for ${e.title}', 'Starts tomorrow${e.date}');
    });
  }

  Future<void> scheduleNotification(int id, String title, String body) async {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    var android = new AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);

    final notDate = tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        notDate,
        // const NotificationDetails(
        //     android: AndroidNotificationDetails('CHANNEL_ID', 'CHANNEL_NAME')),
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

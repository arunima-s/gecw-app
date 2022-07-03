import 'package:flutter/material.dart';
import 'package:gecwapp/Models/calendarEventModel.dart';
import 'package:gecwapp/Models/calendar_datamodel.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  // const CalendarScreen({Key? key}) : super(key: key);
  List<CalendarDataModel> notificationsList = [];

  @override
  Widget build(BuildContext context) {
    print('-----------------Calendar Screen--------------');
    notificationsList = context.watch<CalendarDataProvider>().notifications;
    if (notificationsList.isEmpty) {
      context.read<CalendarDataProvider>().getNotifications();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        showNavigationArrow: true,
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        onTap: (CalendarTapDetails details) {
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
                            height: 80,
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
                                Row(
                                  children: <Widget>[
                                    Text('000000000'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('_timeDetails!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ],
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

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(Meeting(
    //     'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    // meetings.add(
    //     Meeting('Veruthe', startTime, endTime, const Color(0xFF0F8644), false));

    notificationsList.map((e) {
      meetings.add(Meeting(e.title, DateTime.parse(e.date), endTime,
          const Color(0xFF0F8644), false));
    }).toList();
    // meetings.add(Meeting(
    //     'Test Not',
    //     DateTime.parse(notificationsList.first.eventDate),
    //     endTime,
    //     const Color(0xFF0F8644),
    //     false));
    return meetings;
  }
}

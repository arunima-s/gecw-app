import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailsScreen extends StatelessWidget {
  // const NotificationDetails({Key? key}) : super(key: key);
  final int notificationIndex;
  NotificationDetailsScreen(this.notificationIndex);
  NotificationModel? notificationItem;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    notificationItem =
        context.watch<NotificationProvider>().notifications[notificationIndex];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 244),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageBanner(
                  notificationItem!.image, screenHeight * 0.35, screenWidth),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            notificationItem!.user,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Event Date: ${notificationItem!.eventDate}",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: null,
                          icon: Icon(Icons.notifications_active_outlined))
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Details:",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text(notificationItem!.details,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 15,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                          width: 2,
                                          color: AppColors.primaryColor)),
                                )),
                            onPressed: () {
                              openLink(notificationItem!.link);
                            },
                            child: Text(
                              "Register/View Event",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void openLink(String _url) async {
    // final _url =
    //     DropDownDataset.subjectList[dep]![index][widget.isSyllabus ? 1 : 2];
    // "https://stackoverflow.com/questions/68610058/how-to-open-url-in-flutter-app-with-url-launcher";
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}

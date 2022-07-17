import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Constants/values.dart';
import 'package:gecwapp/Models/calendar_datamodel.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/customWidgets/overlayLoader.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:gecwapp/screens/LoginScreens/loginScreen.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNotificationScreen extends StatefulWidget {
  final int notificationCount;
  AddNotificationScreen(this.notificationCount);
  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  File? image;
  DateTime selectedDate = DateTime.now();
  bool progressEnabled = false;
  TextEditingController tapUrlController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  final screenSizes = GWValues().getScreenSizes;

  @override
  Widget build(BuildContext context) {
    // screenSizes = GWValues().getScreenSizes;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              // shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 0, 0),
                  child: Text(
                    "Add Notification",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                GWSpace(0.025, 0),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 200,
                        width: 300,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          // borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.systemWhite,
                        ),
                        child: Center(
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                )
                              : Text("Pick an image"),
                        )),
                  ),
                  onTap: () {
                    pickImage();
                  },
                ),
                SizedBox(
                  height: screenSizes[0] * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          // padding: MaterialStateProperty.a,
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.systemWhite),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor)))),
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text("Pick event date: " +
                          DateFormat('yyyy-MM-dd').format(selectedDate))),
                ),
                SizedBox(
                  height: screenSizes[0] * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenSizes[1] * 0.8,
                    height: screenSizes[0] * 0.08,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Event Name",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 189, 189, 189)))),
                      controller: nameController,
                      textAlign: TextAlign.center,
                      // decoration: InputDecoration(hintText: 'Enter name'),
                    ),
                  ),
                ),
                GWSpace(0.025, 0),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenSizes[1] * 0.8,
                    height: screenSizes[0] * 0.08,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter tap Url",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 189, 189, 189)))),
                      controller: tapUrlController,
                      textAlign: TextAlign.center,
                      // decoration: InputDecoration(hintText: 'Enter name'),
                    ),
                  ),
                ),
                GWSpace(0.025, 0),
                // TextField(
                //   controller: tapUrlController,
                //   textAlign: TextAlign.center,
                //   decoration: InputDecoration(
                //       border: InputBorder.none, hintText: 'Enter tap url'),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenSizes[1] * 0.8,
                    height: screenSizes[0] * 0.08,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: "Enter details",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 189, 189, 189)))),
                      controller: detailsController,
                      textAlign: TextAlign.center,
                      // decoration: InputDecoration(hintText: 'Enter name'),
                    ),
                  ),
                ),
                // TextField(
                //   controller: detailsController,
                //   keyboardType: TextInputType.multiline,
                //   textAlign: TextAlign.center,
                //   decoration: InputDecoration(
                //       border: InputBorder.none, hintText: 'Enter details'),
                // ),
                GWSpace(0.03, 0),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: screenSizes[0] * 0.06,
                    width: screenSizes[1] * 0.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            // padding: MaterialStateProperty.a,
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.systemWhite),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color: AppColors.primaryColor)))),
                        onPressed: (() {
                          if (!tapUrlController.text.isEmpty &&
                              !detailsController.text.isEmpty) {
                            setState(() {
                              progressEnabled = true;
                            });
                            uploadImage(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter all details"),
                            ));
                          }
                        }),
                        child: Text("Upload notification")),
                  ),
                )
              ],
            ),
            progressEnabled ? LoaderTransparent() : Container()
          ],
        ),
      ),
    );
  }

/////////////
////////////////
///////////////Pick image
  pickImage() async {
    var _image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 300);
    if (_image != null) {
      File imageFile = File(_image.path);
      setState(() {
        image = imageFile;
      });
    }
  }

///////////
//////////////
/////////////DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  uploadImage(BuildContext context) async {
    final _firebaseStorage = FirebaseStorage.instance
        .ref()
        .child('notifications')
        .child(basename(image!.path));

    try {
      // var uploadTask = await _firebaseStorage.putFile(image!);
      await _firebaseStorage.putFile(image!).whenComplete(() {
        uploadNotification(_firebaseStorage.getDownloadURL(), context);
      });
    } on FirebaseException catch (e) {
      print("Upload failed: $e");
    }
  }

  uploadNotification(Future<String> imgUrl, BuildContext context) async {
    final notificationRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.notifications); //database reference object

    final calendarRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.calendar);

    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final imageUrl = await imgUrl;
    final uid = await FirebaseAuth.instance.currentUser?.uid;
    final notificationModel = NotificationModel(
        imageUrl,
        nameController.text,
        tapUrlController.text,
        detailsController.text,
        uid.toString(),
        timeStamp,
        DateFormat('yyyy-MM-dd').format(selectedDate));

    final calendarModel = CalendarDataModel(
        nameController.text,
        DateFormat('yyyy-MM-dd hh:mm:ss').format(selectedDate),
        detailsController.text);

    await calendarRef.child(timeStamp).set(calendarModel.toJson());
    await notificationRef
        .child(timeStamp)
        // .child((widget.notificationCount + 1).toString())
        .set(notificationModel.toJson())
        .whenComplete(() {
      setState(() {
        progressEnabled = false;
      });
      print(
        "=======================success=========================",
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Notification will be posted after verification"),
      ));
    });
  }
}

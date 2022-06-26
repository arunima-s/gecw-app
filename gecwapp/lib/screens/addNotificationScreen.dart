import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/customWidgets/overlayLoader.dart';
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
  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: 100,
                ),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.systemWhite,
                        ),
                        child: Center(
                          child: image != null
                              ? Image.file(image!)
                              : Text("Pick an image"),
                        )),
                  ),
                  onTap: () {
                    pickImage();
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child:
                          Text(DateFormat('yyyy-MM-dd').format(selectedDate))),
                ),
                TextField(
                  controller: tapUrlController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Enter tap url'),
                ),
                TextField(
                  controller: detailsController,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Enter details'),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
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

    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final imageUrl = await imgUrl;
    final uid = await FirebaseAuth.instance.currentUser?.uid;
    final notificationModel = await NotificationModel(
        imageUrl,
        tapUrlController.text,
        detailsController.text,
        uid.toString(),
        timeStamp,
        DateFormat('yyyy-MM-dd').format(selectedDate));
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

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNotificationScreen extends StatefulWidget {
  final int notificationCount;
  AddNotificationScreen(this.notificationCount);
  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       pickImage();
            //     },
            //     child: Text("Pick Image"))
            GestureDetector(
              // child: image != null ? Image.file(image!) : Text("Pick an image"),
              child: Container(
                  height: 200,
                  width: 300,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColors.systemWhite,
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: AppColors.grey3,
                    //       offset: Offset(2.0, 2.0),
                    //       spreadRadius: 3.0,
                    //       blurRadius: 2.0)
                    // ]
                  ),
                  child: Center(
                    child: image != null
                        ? Image.file(image!)
                        : Text("Pick an image"),
                  )),
              onTap: () {
                pickImage();
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter tap url'),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter tap url'),
            ),
            ElevatedButton(
                onPressed: (() {
                  uploadImage();
                }),
                child: Text("Upload notification"))
          ],
        ),
      ),
    );
  }

  pickImage() async {
    var _image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 300);
    if (_image != null) {
      File imageFile = File(_image.path);
      setState(() {
        image = imageFile;
      });
    }
    // print(_image?.path);
    // final tempImage = File(_image!.path);
    // setState(() {
    //   image = tempImage;
    // });
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance
        .ref()
        .child('notifications')
        .child(basename(image!.path));

    try {
      // var uploadTask = await _firebaseStorage.putFile(image!);
      await _firebaseStorage.putFile(image!).whenComplete(() {
        uploadNotification(_firebaseStorage.getDownloadURL());
      });
    } on FirebaseException catch (e) {
      print("Upload failed: $e");
    }
  }

  uploadNotification(Future<String> imgUrl) async {
    final notificationRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.notifications); //database reference object
    // await notificationRef.once().then((DataSnapshot snapshot) {
    // final data = snapshot.value as List<dynamic>;
    // print(data);
    // });
    final imageUrl = await imgUrl;
    final notificationModel =
        await NotificationModel(imageUrl, "link", "details");
    await notificationRef
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        // .child((widget.notificationCount + 1).toString())
        .set(notificationModel.toJson());
  }
}

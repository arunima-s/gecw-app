import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({Key? key}) : super(key: key);

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  var selectedSemesterString = "S3";
  var semesterNames = ["S1 - S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  var selectedDepartmentString = "EEE";
  List<String> departmentNames = [];
  var selectedSubject = "";
  List<String> subjectList = [];
  // = ["EEE", "EC", "MECH", "CS"];

  var data = {
    1: "EEE",
    2: "EC",
    3: "IT",
    4: "CS"
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentNames = data.values.toList();
    subjectList = DropDownDataset.subjectList["EEES3"]!;
    selectedSubject = subjectList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Semester"),
            DropdownButton(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              value: selectedSemesterString,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: semesterNames.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSemesterString = newValue.toString();
                  setSubject();
                });
              },
            ),
            ////////////////////////////////////
            ///////////////////////////////////
            //////////////////////////////////
            /////////////////////////////////
            Text("Department"),
            DropdownButton(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              value: selectedDepartmentString,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: departmentNames.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedDepartmentString = newValue.toString();
                  setSubject();
                });
              },
            ),
                        ////////////////////////////////////
            ///////////////////////////////////
            //////////////////////////////////
            /////////////////////////////////
            Text("Subjects"),
            DropdownButton(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              value: selectedSubject,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: subjectList.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: SizedBox(
                    width: 300,
                    child: Text(items)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSubject = newValue.toString();
                  setSubject();
                });
              },
            ),
            ElevatedButton(onPressed: openDrive, child: Text("Get notes"))
          ],
        ),
      ),
    );
  }

  void setSubject() {
    var dep = selectedDepartmentString + selectedSemesterString;
    setState(() {
      subjectList = DropDownDataset.subjectList[dep]!;
      selectedSubject = subjectList.first;
    });
  }
  
  void openDrive() async {
    const _url = "https://stackoverflow.com/questions/68610058/how-to-open-url-in-flutter-app-with-url-launcher";
    await launch(_url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
}
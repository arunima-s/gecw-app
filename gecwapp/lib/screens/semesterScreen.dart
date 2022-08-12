import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Constants/values.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialsScreen extends StatefulWidget {
  // const StudyMaterialsScreen({Key? key}) : super(key: key);
  final bool isSyllabus;
  StudyMaterialsScreen(this.isSyllabus);

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  var selectedSemesterString = "S3";
  var semesterNames = ["S1 - S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  var selectedDepartmentString = "EEE";
  List<String> departmentNames = [];
  var selectedSubject = "";
  List<dynamic> subjectList = [];
  // = ["EEE", "EC", "MECH", "CS"];
  double screenHeight = 0, screenWidth = 0;

  var data = {1: "EEE", 2: "EC", 3: "MECH", 4: "CS"};

  @override
  void initState() {
    super.initState();
    departmentNames = data.values.toList();
    subjectList =
        DropDownDataset.subjectList["EEES3"]!.map((e) => e.first).toList();
    selectedSubject = subjectList.first;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = context.watch<GWValuesProvider>().height;
    screenWidth = context.watch<GWValuesProvider>().width;
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(
                    "Semester",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  border: Border.all(color: AppColors.systemBlack),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton(
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
            ),
            ////////////////////////////////////
            ///////////////////////////////////
            //////////////////////////////////
            /////////////////////////////////
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Department",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              // width: double.infinity,
              width: MediaQuery.of(context).size.width * 0.6,

              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  border: Border.all(color: AppColors.systemBlack),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton(
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
            ),
            ////////////////////////////////////
            ///////////////////////////////
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Subjects",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              // width: double.infinity,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  border: Border.all(color: AppColors.systemBlack),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton(
                isExpanded: true,
                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                value: selectedSubject,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: subjectList.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: SizedBox(width: 300, child: Text(items)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSubject = newValue.toString();
                    // setSubject();
                  });
                },
              ),
            ),
            // ElevatedButton(onPressed: openDrive, child: Text("Get notes"))
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoundedButton(
                  widget.isSyllabus ? 'Get Syllabus' : 'Get Notes',
                  openDrive,
                  screenWidth * 0.4,
                  screenHeight * 0.06),
            )
          ],
        ),
      ),
    );
  }

  void setSubject() {
    String dep;
    if (selectedSemesterString == "S1 - S2") {
      dep = "S1 - S2";
    } else {
      dep = selectedDepartmentString + selectedSemesterString;
    }
    setState(() {
      subjectList =
          DropDownDataset.subjectList[dep]!.map((e) => e.first).toList();
      selectedSubject = subjectList.first;
    });
  }

  void openDrive() async {
    String dep;
    if (selectedSemesterString == "S1 - S2") {
      dep = "S1 - S2";
    } else {
      dep = selectedDepartmentString + selectedSemesterString;
    }
    // final dep = selectedDepartmentString + selectedSemesterString;
    final index = subjectList.indexOf(selectedSubject);
    final _url = DropDownDataset.subjectList[dep]![index]
            [widget.isSyllabus ? 1 : 2]
        .toString();
    // "https://stackoverflow.com/questions/68610058/how-to-open-url-in-flutter-app-with-url-launcher";
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}

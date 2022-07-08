import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Constants/strings.dart';
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

  var data = {1: "EEE", 2: "EC", 3: "MECH", 4: "CS"};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentNames = data.values.toList();
    subjectList =
        DropDownDataset.subjectList["EEES3"]!.map((e) => e.first).toList();
    selectedSubject = subjectList.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Semester"),
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
            Text("Department"),
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
            ///////////////////////////////////
            Text("Subjects"),
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
            ElevatedButton(onPressed: openDrive, child: Text("Get notes"))
          ],
        ),
      ),
    );
  }

  void setSubject() {
    final dep = selectedDepartmentString + selectedSemesterString;
    setState(() {
      subjectList =
          DropDownDataset.subjectList[dep]!.map((e) => e.first).toList();
      selectedSubject = subjectList.first;
    });
  }

  void openDrive() async {
    final dep = selectedDepartmentString + selectedSemesterString;
    final index = subjectList.indexOf(selectedSubject);
    final _url = DropDownDataset.subjectList[dep]![index][1];
    // "https://stackoverflow.com/questions/68610058/how-to-open-url-in-flutter-app-with-url-launcher";
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}

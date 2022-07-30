import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';

class BunkManagerScreen extends StatefulWidget {
  // const BunkManagerScreen({Key? key}) : super(key: key);
  @override
  State<BunkManagerScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BunkManagerScreen> {
  var attend = "";
  var needed = "";

  final totalClassController = new TextEditingController();
  final attendController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: SafeArea(
        child: Container(
          width: screenWidth * 0.9,
          // height: screenHeight * 0.4,
          decoration: BoxDecoration(
              color: AppColors.systemWhite,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Classes"),
                      // RoundedButton(
                      //     "-", () {}, screenWidth * 0.1, screenHeight * 0.05),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: totalClassController,
                          decoration: InputDecoration(
                              // suffixIcon: Icon(Icons.search),
                              // hintText: "Search",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)))),
                        ),
                      ),
                      // RoundedButton(
                      //     "+", () {}, screenWidth * 0.1, screenHeight * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Attended Classes"),
                      // RoundedButton(
                      //     "-", () {}, screenWidth * 0.1, screenHeight * 0.05),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: attendController,
                          decoration: InputDecoration(
                              // suffixIcon: Icon(Icons.search),
                              // hintText: "Search",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)))),
                        ),
                      ),
                      // RoundedButton(
                      //     "+", () {}, screenWidth * 0.1, screenHeight * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Text(
                    "        Your current attendece is $attend%         ",
                    style: TextStyle(
                        backgroundColor: Colors.yellow, color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 30),
                  child: Text(
                    "        Classes you should attend are $needed         ",
                    style: TextStyle(
                        backgroundColor: Colors.yellow, color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RoundedButton("Calculate", () {
                    calculate();
                  }, screenWidth * 0.6, screenHeight * 0.07),
                )
              ]),
        ),
      ),
    );
  }

  void calculate() {
    final totalClass = totalClassController.text.toString();
    final attandClass = attendController.text.toString();

    if (totalClass.isEmpty || attandClass.isEmpty) {
      Messages.displayMessage(context, "Empty");
    } else {
      final _totalClass = double.parse(totalClassController.text.toString());
      final _attandClass = double.parse(attendController.text.toString());
      setState(() {
        attend = (100 - (((_totalClass - _attandClass) / _totalClass) * 100))
            .toString();

        needed = (((.75 * _totalClass) - _attandClass) / 0.25).toString();
      });
    }
  }
}

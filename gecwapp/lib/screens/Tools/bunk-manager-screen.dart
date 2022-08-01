import 'package:auto_size_text/auto_size_text.dart';
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
          width: screenWidth,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  AutoSizeText(
                    "Bunk Manager",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.92,
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
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   width: screenWidth * 0.31,
                                  // ),
                                  RoundedButton("-", () {
                                    setState(() {
                                      if (totalClassController
                                          .text.isNotEmpty) {
                                        totalClassController.text = (int.parse(
                                                    totalClassController.text) -
                                                1)
                                            .toString();
                                      }
                                    });
                                  }, screenWidth * 0.1, screenHeight * 0.05),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      controller: totalClassController,
                                      decoration: InputDecoration(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  RoundedButton("+", () {
                                    setState(() {
                                      if (totalClassController
                                          .text.isNotEmpty) {
                                        totalClassController.text = (int.parse(
                                                    totalClassController.text) +
                                                1)
                                            .toString();
                                      }
                                    });
                                  }, screenWidth * 0.1, screenHeight * 0.05),
                                ])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Attended Classes"),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   width: screenWidth * 0.31,
                                  // ),
                                  RoundedButton("-", () {
                                    setState(() {
                                      if (attendController.text.isNotEmpty) {
                                        attendController.text =
                                            (int.parse(attendController.text) -
                                                    1)
                                                .toString();
                                      }
                                    });
                                  }, screenWidth * 0.1, screenHeight * 0.05),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      controller: attendController,
                                      decoration: InputDecoration(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  RoundedButton("+", () {
                                    setState(() {
                                      if (attendController.text.isNotEmpty) {
                                        attendController.text =
                                            (int.parse(attendController.text) +
                                                    1)
                                                .toString();
                                      }
                                    });
                                  }, screenWidth * 0.1, screenHeight * 0.05),
                                ])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 30),
                        child: Text(
                          "$attend",
                          style: TextStyle(
                              backgroundColor: Colors.yellow,
                              color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 30),
                        child: Text(
                          "$needed",
                          style: TextStyle(
                              backgroundColor: Colors.yellow,
                              color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: RoundedButton("Calculate", () {
                          // if (totalClassController.text.isNotEmpty &&
                          //     attendController.text.isEmpty) {
                          calculate();
                          // } else {
                          //   Messages.displayMessage(context, "Enter values");
                          // }
                        }, screenWidth * 0.6, screenHeight * 0.07),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toogleValue() {
    setState(() {});
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
        attend =
            "   Your current attendence is: ${double.parse((100 - (((_totalClass - _attandClass) / _totalClass) * 100)).toStringAsFixed(2)).toString()}%     ";

        needed =
            "   Classes you need to attend are: ${(((.75 * _totalClass) - _attandClass) / 0.25).toString()}       ";
      });
    }
  }
}

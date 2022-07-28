import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/bicycle-model.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/bicycle-provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/screens/Bicycleclub%20Screens/bicycle-details-screen.dart';
import 'package:provider/provider.dart';

class BicycleScreen extends StatelessWidget {
  // const BicycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    context.read<BicycleProvider>().getBicycleList();
    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BicycleScreenItem(0),
                BicycleScreenItem(1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BicycleScreenItem(2),
                BicycleScreenItem(3),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BicycleScreenItem extends StatelessWidget {
  UserModel? _userModel;
  final int index;
  BicycleScreenItem(this.index);
  List<BicycleClubModel> bicycleList = [];
  @override
  Widget build(BuildContext context) {
    _userModel = context.watch<UserProvider>().userModel;
    bicycleList = context.watch<BicycleProvider>().bicycles;
    print(bicycleList);
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return !bicycleList.isEmpty
        ? Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: bicycleList[index].user == _userModel!.mail
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BicycleClubDetailsScreen(index)));
                              }
                            : () {
                                Messages.displayMessage(context,
                                    "Return the cycle you are using currently");
                              },
                        child: Text(bicycleList[index].user == _userModel!.mail
                            ? "Return"
                            : "Book"))
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              color: bicycleList[index].isFree
                  ? Colors.green[100]
                  : Colors.red[100],
            ),
            width: screenWidth * 0.4,
            height: screenWidth * 0.4,
          )
        : SizedBox();
  }
}

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:gecwapp/screens/Bicycleclub%20Screens/bicycle-admin-screen.dart';
import 'package:gecwapp/screens/Bicycleclub%20Screens/bicycle-details-screen.dart';
import 'package:provider/provider.dart';

class BicycleScreen extends StatelessWidget {
  // const BicycleScreen({Key? key}) : super(key: key);
  UserModel? userData;

  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserProvider>().userModel;
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    context.read<BicycleProvider>().getBicycleList();
    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: Container(
        width: screenWidth,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /////
                //////Back Button
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                AutoSizeText(
                  "Bicycle Booking",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                ),
                /////////////
                ////////////Verify button
                (userData!.access == 2 || userData!.access == 3)
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BicycleAdmin()));
                        },
                        icon: Icon(Icons.verified))
                    : SizedBox(),
                ////////////
                ///////////Add Button
                // (userData!.access == 1 || userData!.access == 2)
                //     ? IconButton(
                //         onPressed: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => AddNotificationScreen(
                //                   notificationsList.length)));
                //         },
                //         icon: Icon(Icons.edit))
                //     : SizedBox(),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BicycleScreenItem(0),
                BicycleScreenItem(1),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
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
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BicycleClubDetailsScreen(index)));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ElevatedButton(
                      //     onPressed: bicycleList[index].user == _userModel!.mail
                      //         ? () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         BicycleClubDetailsScreen(index)));
                      //           }
                      //         : () {
                      //             Messages.displayMessage(context,
                      //                 "Return the cycle you are using currently");
                      //           },
                      //     child: Text(bicycleList[index].user == _userModel!.mail
                      //         ? "Return"
                      //         : "Book"))
                    ],
                  ),
                  Text(
                    "Bicycle 1",
                    style: TextStyle(
                        color: AppColors.systemWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Image.asset(
                    bicycleList[index].user == _userModel!.mail
                        ? 'assets/images/bicycle-ride.gif'
                        : 'assets/images/bicycle-stop.png',
                    width: screenWidth * 0.25,
                  ),
                  Text(
                    bicycleList[index].isFree ? "Available" : "Unavailable",
                    style: TextStyle(
                        color: AppColors.systemWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: bicycleList[index].isFree
                    ? AppColors.bicycleStop
                    : AppColors.bicycleGif,
              ),
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
          )
        : SizedBox();
  }
}

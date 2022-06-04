import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/imagebanner.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelDetailsScreen extends StatelessWidget {
  final HostelListModel _hostelListModel;
  final List<String> imgList = [
    'https://picsum.photos/id/1/300/200',
    'https://picsum.photos/id/2/300/200',
    'https://picsum.photos/id/3/300/200',
    'https://picsum.photos/id/4/300/200',
    'https://picsum.photos/id/5/300/200',
    'https://picsum.photos/id/6/300/200'
  ];

  final List<String> localImages = [
    'assets/images/room1.jpeg',
    'assets/images/room2.jpeg',
    'assets/images/room1.jpeg',
    'assets/images/room2.jpeg',
  ];

  HostelDetailsScreen(this._hostelListModel);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.lightBlue,
        //   title: Text(_hostelListModel.name),
        // ),

        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            //Images
            // ImageBanner(_hostelListModel.image),
            Container(
              // color: Colors.red,
              // decoration: BoxDecoration(),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Swiper(
                itemCount: localImages.length,
                itemBuilder: (context, index) => Card(
                  child: Image.asset(
                    localImages[index],
                    fit: BoxFit.fill,
                  ),
                ),
                pagination:
                    const SwiperPagination(alignment: Alignment.topCenter),
              ),
            ),

            //Top layer
            // IgnorePointer(
            //   child:
            Positioned(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 200,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height * 0.3) -
                            MediaQuery.of(context).size.height * 0.05),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50)),
                      color: Colors.white,
                      // boxShadow: [
                      // BoxShadow(
                      //     color: AppColors.grey3,
                      //     offset: Offset(0.0, -0.1),
                      //     // spreadRadius: 3.0,
                      //     blurRadius: 2.0)
                      // ]
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                    // height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _hostelListModel.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _hostelListModel.details,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color.fromRGBO(99, 95, 94, 1)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(_hostelListModel.price,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "per month",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(99, 95, 94, 1)),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                                height: MediaQuery.of(context).size.width * .15,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.primaryColor),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.systemWhite),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: AppColors.primaryColor)))),
                                    onPressed: _onCallButtonTapped,
                                    child: Icon(Icons.phone_outlined)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .70,
                                height: MediaQuery.of(context).size.width * .15,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.systemWhite),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.primaryColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                    color:
                                                        AppColors.primaryColor)))),
                                    onPressed: _onLocationTapped,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.directions_outlined),
                                        Text("Location"),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // )
          ],
        ),

        // body: ListView(
        //   // mainAxisAlignment: MainAxisAlignment.start,
        //   // crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     ImageBanner(_hostelListModel.image),
        //     Container(
        //       // margin: EdgeInsets.only(top: -10),
        //       color: Colors.yellow,
        //       child: SizedBox(
        //         height: 500,
        //       ),
        //     )
        //     // Row(
        //     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     //   children: [
        //     //     Expanded(
        //     //       flex: 2,
        //     //       child: ElevatedButton(
        //     //         style: ElevatedButton.styleFrom(primary: Colors.green),
        //     //         onPressed: _onLocationTapped,
        //     //         child: Text(
        //     //           "Location",
        //     //           style: TextStyle(fontSize: 20, color: Colors.white),
        //     //         ),
        //     //       ),
        //     //     ),
        //     //     Expanded(
        //     //       flex: 2,
        //     //       child: ElevatedButton(
        //     //         style: ElevatedButton.styleFrom(primary: Colors.blue),
        //     //         onPressed: _onCallButtonTapped,
        //     //         child: Text(
        //     //           "Call",
        //     //           style: TextStyle(fontSize: 20, color: Colors.white),
        //     //         ),
        //     //       ),
        //     //     )
        //     //   ],
        //     // )
        //   ],
        // )
      ),
    );
  }

  void _onLocationTapped() {
    MapsLauncher.launchQuery(_hostelListModel.location);
    // MapsLauncher.launchCoordinates(8.557810283707571, 76.8716414692874);
  }

  void _onCallButtonTapped() async {
    // var url = _hostelListModel.phoneNum;
    // if (await canLaunch(url)) {
    await launch(_hostelListModel.phoneNum);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

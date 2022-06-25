import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/imagebanner.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.lightBlue,
        //   title: Text(_hostelListModel.name),
        // ),

        body: Stack(
          children: [
            //Images
            // ImageBanner(_hostelListModel.image),
            Container(
              // decoration: BoxDecoration(),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Swiper(
                itemCount: _hostelListModel.images.length,
                itemBuilder: (context, index) => Image.network(
                  _hostelListModel.images[index],
                  fit: BoxFit.fill,
                ),
                pagination:
                    const SwiperPagination(alignment: Alignment.topCenter),
              ),
            ),

            //Top layer
            // IgnorePointer(
            //   child:
            Positioned(
              // top: 10.0,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 200,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height * 0.3) -
                            MediaQuery.of(context).size.height * 0.02),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      // color: Color.fromARGB(255, 246, 246, 246),
                    ),
                    height: MediaQuery.of(context).size.height * 0.67,
                    // height: double.infinity,
                    child: Text('sdhbfgds'),
                  )
                ],
              ),
            ),
            // )
            //////////
            ///////////// Middle portion
            /////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.85,
                  margin: EdgeInsets.fromLTRB(0, screenHeight * 0.225, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.systemWhite,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.grey3,
                            offset: Offset(2.0, 2.0),
                            spreadRadius: 1.0,
                            blurRadius: 2.0)
                      ]),
                  ////////////////
                  //////////////////
                  ///////////////////Middle Content
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hostelListModel.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          _hostelListModel.address,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                        color: Colors.grey[400],
                        height: 0.5,
                      ),
                      Row(
                        children: [
                          AmnityWidget(
                              _hostelListModel.hasFood ? "food" : "no food",
                              Icon(Icons.food_bank)),
                          AmnityWidget(
                              _hostelListModel.hasRoom ? "room" : "dormitory",
                              Icon(Icons.bed))
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      //   child: Text('Warden: ${_hostelListModel.phoneNum}'),
                      // )
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 30,
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
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color:
                                                    AppColors.primaryColor)))),
                                onPressed: _onLocationTapped,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Location')
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            /////////////////
            ///////////////
            /////////////// Bottom portion
            Positioned(
              bottom: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.systemWhite,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 177, 177, 177),
                          offset: Offset(0.0, -3.0),
                          spreadRadius: 2.0,
                          blurRadius: 5.0)
                    ]),
                width: screenWidth,
                height: screenHeight * 0.09,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Divider(
                    //   color: Colors.black,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Warden: ${_hostelListModel.warden}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('+91 ${_hostelListModel.phoneNum}')
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          // width: screenWidth * .13,
                          height: screenWidth * .1,
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
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color: AppColors.primaryColor)))),
                              onPressed: _onCallButtonTapped,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.phone_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Call')
                                ],
                              )),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * .70,
                        //   height: MediaQuery.of(context).size.width * .15,
                        //   child: ElevatedButton(
                        //       style: ButtonStyle(
                        //           foregroundColor: MaterialStateProperty.all<Color>(
                        //               AppColors.systemWhite),
                        //           backgroundColor: MaterialStateProperty.all<Color>(
                        //               AppColors.primaryColor),
                        //           shape: MaterialStateProperty.all<
                        //                   RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(12.0),
                        //                   side: BorderSide(
                        //                       color: AppColors.primaryColor)))),
                        //       onPressed: _onLocationTapped,
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Icon(Icons.directions_outlined),
                        //           Text("Location"),
                        //         ],
                        //       )),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //////////
            //////////
            //////////Back arrow
            Positioned(
              left: 15.0,
              top: 15.0,
              child: Container(
                width: 40,
                height: 40,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(25)),
                //   // color: AppColors.systemWhite,
                // ),
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: Navigator.of(context).pop),
              ),
            )
          ],
        ),
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
    // await launch(url);
    await URLLauncher.launch('tel:+${_hostelListModel.phoneNum.toString()}');
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

class AmnityWidget extends StatelessWidget {
  final String _text;
  final Icon _icon;
  AmnityWidget(this._text, this._icon);
  // const AminityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon,
          Text(
            _text,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/imagebanner.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;

class HostelDetailsScreen extends StatelessWidget {
  HostelListModel? _hostelListModel;
  final int _index;
  HostelDetailsScreen(this._index);
  @override
  Widget build(BuildContext context) {
    _hostelListModel = context.watch<HostelProvider>().hostels[_index];
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
                itemCount: _hostelListModel!.images.length,
                itemBuilder: (context, index) => Image.network(
                  _hostelListModel!.images[index],
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.34,
                        ),
                        Text("")
                      ],
                    ),
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
                        _hostelListModel!.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          _hostelListModel!.address,
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
                              _hostelListModel!.hasFood ? "food" : "no food",
                              Icon(Icons.food_bank)),
                          AmnityWidget(
                              _hostelListModel!.hasRoom ? "room" : "dormitory",
                              Icon(Icons.bed))
                        ],
                      ),
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
                                    Icon(Icons.directions),
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
                                'Warden: ${_hostelListModel!.warden}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('+91 ${_hostelListModel!.phoneNum}')
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
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //     icon: Icon(Icons.arrow_back_ios_new),
                    //     onPressed: Navigator.of(context).pop),
                    GWRoundedIcon(Navigator.of(context).pop,
                        Icon(Icons.arrow_back_ios_new)),
                    GWRoundedIcon(
                        Navigator.of(context).pop,
                        Icon(
                          Icons.share,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLocationTapped() {
    MapsLauncher.launchQuery(_hostelListModel!.location);
    // MapsLauncher.launchCoordinates(8.557810283707571, 76.8716414692874);
  }

  void _onCallButtonTapped() async {
    await URLLauncher.launch('tel:+${_hostelListModel!.phoneNum.toString()}');
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

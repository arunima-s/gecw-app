import 'package:flutter/material.dart';
import 'package:gecwapp/CustomWidgets/imagebanner.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelDetailsScreen extends StatelessWidget {
  final HostelListModel _hostelListModel;

  HostelDetailsScreen(this._hostelListModel);
  @override
  Widget build(BuildContext context) {
    // final location = LocationModel.fetchById(_locationID);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text(_hostelListModel.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBanner(_hostelListModel.image),
            // TextContainer(location.name, "Something title"),
          ]..add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: _onLocationTapped,
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: _onCallButtonTapped,
                    child: Text(
                      "Call",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
        ));
  }

  void _onLocationTapped() {
    MapsLauncher.launchCoordinates(8.557810283707571, 76.8716414692874);
  }

  void _onCallButtonTapped() async {
    const url = 'tel:+919876543210';
    // if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

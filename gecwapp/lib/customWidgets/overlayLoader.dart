import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:provider/provider.dart';

class LoaderTransparent extends StatelessWidget {
// double height;
// double width;
// Color colorValue;
// LoaderTransparent({this.colorValue});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child:
                    //Image.asset('assets/images/loader.gif',fit: BoxFit.fill,) // use you custom loader or default loader
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        strokeWidth: 5.0))));
  }
}

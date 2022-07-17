class GWValues {
  List<double>? screenSizes;
  double? screenHeight, screenWidth;
  List get getScreenSizes {
    return screenSizes ?? [715, 411];
  }

  double get getScreenHeight {
    return screenHeight ?? 715;
  }

  double get getScreenWidth {
    return screenWidth ?? 411;
  }

  set setScreenSizes(List<double> size) {
    screenSizes = size;
  }
}

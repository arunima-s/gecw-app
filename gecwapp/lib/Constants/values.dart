class GWValues {
  List<double>? screenSizes;
  List get getScreenSizes {
    return screenSizes ?? [715, 411];
  }

  set setScreenSizes(List<double> size) {
    screenSizes = size;
  }
}

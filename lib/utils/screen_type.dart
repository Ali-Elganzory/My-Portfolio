import 'package:flutter/cupertino.dart';

enum ScreenType {
  Desktop,
  Tablet,
  Mobile,
}

ScreenType getScreenType(MediaQueryData mediaQueryData) {
  double shortestSide = mediaQueryData.size.shortestSide;

  if (shortestSide > 900)
    return ScreenType.Desktop;
  else if (shortestSide > 600)
    return ScreenType.Tablet;
  else
    return ScreenType.Mobile;
}

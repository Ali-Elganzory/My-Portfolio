import 'package:flutter/material.dart';

import 'package:portfolio/utils/screen_type.dart';

class ResponsiveLayout extends StatelessWidget {
  ResponsiveLayout({
    this.desktop,
    this.tablet,
    this.mobile,
    Key key,
  }) : super(key: key);

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = getScreenType(MediaQuery.of(context));
    switch (screenType) {
      case ScreenType.Desktop:
        return desktop ?? NoView();
        break;
      case ScreenType.Tablet:
        return tablet ?? NoView();
        break;
      case ScreenType.Mobile:
        return mobile ?? NoView();
        break;
      default:
        return NoView();
    }
  }
}

class NoView extends StatelessWidget {
  const NoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Text("This view is not supported!"),
        ),
      ),
    );
  }
}

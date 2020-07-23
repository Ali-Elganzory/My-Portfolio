import 'package:flutter/material.dart';

import 'package:portfolio/constants/colors.dart';

import 'package:portfolio/utils/screen_type.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.sh,
    @required this.sw,
  }) : super(key: key);

  final double sh;
  final double sw;

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = getScreenType(MediaQuery.of(context));
    return Container(
      height: 0.15 * sh,
      width: sw,
      constraints: BoxConstraints(
        maxHeight: 110,
        minHeight: 80,
      ),
      child: Container(
        color: MyColors.primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: 0.05 * sw < 20 ? 20 : 0.05 * sw > 50 ? 50 : 0.05 * sw,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: sw < 1100 ? 0.10 * sh : 0.15 * sh - 20,
              constraints: BoxConstraints(
                maxHeight: 85,
                minHeight: 40,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: AssetImage(
                    'assets/images/personal_photo.jpg',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hi! I'm Ali Elganzory",
                    style: TextStyle(
                      fontSize: screenType == ScreenType.Desktop
                          ? 32
                          : screenType == ScreenType.Tablet ? 26 : 22,
                      color: MyColors.textColor1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Mobile App Developer",
                    style: TextStyle(
                      fontSize: screenType == ScreenType.Desktop
                          ? 24
                          : screenType == ScreenType.Tablet ? 18 : 16,
                      color: MyColors.textColor1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              child: Text(
                "Say hi!",
                style: TextStyle(
                  fontSize: screenType == ScreenType.Desktop
                          ? 32
                          : screenType == ScreenType.Tablet ? 24 : 18,
                  fontFamily: "GochiHand",
                  color: MyColors.accentColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import '../components/carousel_slider.dart';

import '../constants/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final carouselsProvider = _CarouselsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'images/personal_photo.jpg',
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
                            fontSize: 36,
                            color: MyColors.textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Mobile Apps Developer",
                          style: TextStyle(
                            fontSize: 22,
                            color: MyColors.textColor1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                    Colors.deepPurpleAccent,
                    Colors.deepPurple,
                  ],
                  stops: [
                    0.0,
                    0.2,
                    0.8,
                    1.0,
                  ],
                ),
              ),
              child: CarouselSlider.builder(
                key: _CarouselsProvider.appsCarouselKey,
                itemCount: _CarouselsProvider.appsCount,
                itemBuilder: (ctx, index) => CarouselTest(
                  carouselKey: _CarouselsProvider.screensCarouselKeys[index],
                  children: _CarouselsProvider.appScreens[index],
                ),
                autoPlay: false,
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.easeInOutCubic,
                enableInfiniteScroll: true,
                enlargeCenterPage: false,
                initialPage: 0,
                viewportFraction: 1.0,
                pauseAutoPlayOnTouch: Duration(seconds: 4),
              ),
            ),
          ),
          Positioned(
            top: 110,
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // 1st part of horizontal different-app navigation
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          (_CarouselsProvider.appsCarouselKey.currentWidget
                                  as CarouselSlider)
                              .previousPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutCubic,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    //  vertical same-app navigation
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              (_CarouselsProvider.appsCarouselKey.currentWidget
                                      as CarouselSlider)
                                  .previousPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            icon: Transform.rotate(
                              angle: pi / 2,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              (_CarouselsProvider.appsCarouselKey.currentWidget
                                      as CarouselSlider)
                                  .previousPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            icon: Transform.rotate(
                              angle: -pi / 2,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 2nd part of horizontal different-app navigation
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          (_CarouselsProvider.appsCarouselKey.currentWidget
                                  as CarouselSlider)
                              .nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutCubic,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class CarouselTest extends StatelessWidget {
  final List<Widget> children;
  final GlobalKey<CarouselSliderState> carouselKey;
  CarouselTest({
    Key key,
    this.carouselKey,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      key: carouselKey,
      itemCount: children.length,
      itemBuilder: (ctx, index) => Container(
        height: 0.8 * (MediaQuery.of(context).size.height - 150),
        child: children[index],
        color: Colors.transparent,
      ),
      autoPlay: true,
      autoPlayAnimationDuration: Duration(milliseconds: 1000),
      autoPlayCurve: Curves.easeInOutCubic,
      enableInfiniteScroll: true,
      enlargeCenterPage: false,
      initialPage: 0,
      viewportFraction: 1.0,
      scrollDirection: Axis.vertical,
      pauseAutoPlayOnTouch: Duration(seconds: 4),
    );
  }
}

class _CarouselsProvider {
  static int appsCount = 4;
  static List<int> appScreensCount = [4, 4, 4, 4];

  static final GlobalKey<CarouselSliderState> appsCarouselKey = GlobalKey();
  static List<GlobalKey<CarouselSliderState>> screensCarouselKeys =
      List.generate(
    appsCount,
    (index) {
      return GlobalKey();
    },
  );

  static List<List<Widget>> appScreens = [
    [
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
    ],
    [
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
    ],
    [
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
    ],
    [
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
      Image.asset("images/test_pic.png"),
    ],
  ];
}

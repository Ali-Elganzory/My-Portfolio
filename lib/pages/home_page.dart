import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/providers/src/provider.dart';

import '../providers/src/selector.dart';
import '../providers/carousels.dart';

import '../constants/colors.dart';

import '../components/carousel_slider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body:  Container(
          height: sh,
          width: sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //  Header
              Container(
                height: 0.15 * sh,
                width: sw,
                constraints: BoxConstraints(
                  maxHeight: 110,
                  minHeight: 80,
                ),
                child: Container(
                  color: MyColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 0.15 * sh - 20,
                        constraints: BoxConstraints(
                          maxHeight: 90,
                          minHeight: 60,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            image: AssetImage(
                              'assets/personal_photo.jpg',
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
                                fontSize: 36 * 0.15 * sh / 110 < 36 * 80 / 110
                                    ? 36 * 80 / 110
                                    : 36 * 0.15 * sh / 110,
                                color: MyColors.textColor1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Mobile Apps Developer",
                              style: TextStyle(
                                fontSize: 24 * 0.15 * sh / 110 < 24 * 80 / 110
                                    ? 24 * 80 / 110
                                    : 24 * 0.15 * sh / 110,
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
              //  Gallery
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      //  Screens Carousel Sliders
                      top: 0,
                      bottom: 0,
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
                          key: CarouselsProvider.appsCarouselKey,
                          itemCount: CarouselsProvider.appsCount,
                          itemBuilder: (ctx, index) => SingleAppCarousel(
                            index: index,
                            carouselKey:
                                CarouselsProvider.screensCarouselKeys[index],
                            children: CarouselsProvider.appScreens[index],
                          ),
                          autoPlay: false,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.easeInOutCubic,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false,
                          initialPage: 0,
                          viewportFraction: 1.0,
                          pauseAutoPlayOnTouch: Duration(seconds: 4),
                          onPageChanged: (n) {
                            Provider.of<CarouselsProvider>(context,
                                    listen: false)
                                .selectApp(n);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      //  Screens Navigation
                      top: 0,
                      bottom: 0,
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
                                  (CarouselsProvider.appsCarouselKey
                                          .currentWidget as CarouselSlider)
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
                            Selector<CarouselsProvider, int>(
                              selector: (context, carouselsProvider) =>
                                  carouselsProvider.selectedAppIndex,
                              builder: (context, selectedAppIndex, ch) =>
                                  Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        (CarouselsProvider
                                                    .screensCarouselKeys[
                                                        selectedAppIndex %
                                                            CarouselsProvider
                                                                .appsCount]
                                                    .currentWidget
                                                as CarouselSlider)
                                            .nextPage(
                                          duration:
                                              Duration(milliseconds: 1000),
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
                                        (CarouselsProvider
                                                    .screensCarouselKeys[
                                                        selectedAppIndex %
                                                            CarouselsProvider
                                                                .appsCount]
                                                    .currentWidget
                                                as CarouselSlider)
                                            .previousPage(
                                          duration:
                                              Duration(milliseconds: 1000),
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
                            ),
                            // 2nd part of horizontal different-app navigation
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  (CarouselsProvider.appsCarouselKey
                                          .currentWidget as CarouselSlider)
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
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          AppNavigationButton(n: 0, sw: sw),
                          AppNavigationButton(n: 1, sw: sw),
                          const SizedBox(width: 80),
                          AppNavigationButton(n: 2, sw: sw),
                          AppNavigationButton(n: 3, sw: sw),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.05 * sh,
                width: sw,
                constraints: BoxConstraints(
                  maxHeight: 40,
                  minHeight: 25,
                ),
                color: MyColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Made with  ",
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColors.textColor1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.pink.shade400,
                      size: 18,
                    ),
                    Text(
                      "  in Egypt",
                      style: TextStyle(
                        fontSize: 12,
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
      
    );
  }
}

class SingleAppCarousel extends StatelessWidget {
  final int index;
  final List<Widget> children;
  final GlobalKey<CarouselSliderState> carouselKey;
  SingleAppCarousel({
    Key key,
    this.index,
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

class AppNavigationButton extends StatelessWidget {
  final int n;
  final sw;

  const AppNavigationButton({
    Key key,
    this.n,
    this.sw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CarouselsProvider, int>(
      selector: (context, carouselsProvider) =>
          carouselsProvider.selectedAppIndex,
      builder: (context, selectedAppIndex, ch) {
        int cn = selectedAppIndex;
        
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0.03 * sw),
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: MyColors.primaryColor,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: CircleAvatar(
                radius: n == cn ? 20.0 : 17.0,
                backgroundColor:
                    n == cn ? Colors.pink.shade700 : MyColors.darkPrimaryColor,
                child: Icon(
                  CarouselsProvider.appsIcons[n],
                  color: n == cn ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

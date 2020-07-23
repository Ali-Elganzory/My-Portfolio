import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:portfolio/components/carousel_slider.dart';
import 'package:portfolio/providers/carousels.dart';

import './single_app_carousel.dart';
import './app_navigation_button.dart';

class Gallery extends StatelessWidget {
  const Gallery({
    Key key,
    @required this.sh,
    @required this.sw,
  }) : super(key: key);

  final double sh;
  final double sw;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              itemCount: CarouselsProvider.appCount,
              itemBuilder: (ctx, index) => SingleAppCarousel(
                index: index,
                carouselKey:
                    CarouselsProvider.screensCarouselKeys[index],
                children: CarouselsProvider.appScreens[index],
              ),
              autoPlay: false,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInOutCubic,
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
              initialPage: 0,
              height: double.maxFinite,
              viewportFraction: 1.0,
              pauseAutoPlayOnTouch: Duration(seconds: 4),
              onPageChanged: (n) {
                Provider.of<CarouselsProvider>(context, listen: false)
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
            padding: EdgeInsets.symmetric(
              horizontal: 0.05 * sw < 20
                  ? 20
                  : 0.05 * sw > 50 ? 50 : 0.05 * sw,
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
                      (CarouselsProvider.appsCarouselKey.currentWidget
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
                Selector<CarouselsProvider, int>(
                  selector: (context, carouselsProvider) =>
                      carouselsProvider.selectedAppIndex,
                  builder: (context, selectedAppIndex, ch) => Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            (CarouselsProvider
                                    .screensCarouselKeys[
                                        selectedAppIndex %
                                            CarouselsProvider
                                                .appCount]
                                    .currentWidget as CarouselSlider)
                                .nextPage(
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
                            (CarouselsProvider
                                    .screensCarouselKeys[
                                        selectedAppIndex %
                                            CarouselsProvider
                                                .appCount]
                                    .currentWidget as CarouselSlider)
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
                ),
                // 2nd part of horizontal different-app navigation
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      (CarouselsProvider.appsCarouselKey.currentWidget
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
    );
  }
}


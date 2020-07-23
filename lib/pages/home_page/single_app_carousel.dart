import 'package:flutter/material.dart';

import 'package:portfolio/components/carousel_slider.dart';

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
        height: 0.7 * (MediaQuery.of(context).size.height - 50),
        child: children[index],
        color: Colors.transparent,
      ),
      autoPlay: true,
      autoPlayAnimationDuration: Duration(milliseconds: 1000),
      autoPlayCurve: Curves.easeInOutCubic,
      enableInfiniteScroll: true,
      enlargeCenterPage: false,
      initialPage: 0,
      height: 0.7 * (MediaQuery.of(context).size.height - 50),
      viewportFraction: 1.0,
      scrollDirection: Axis.vertical,
      pauseAutoPlayOnTouch: Duration(seconds: 4),
    );
  }
}



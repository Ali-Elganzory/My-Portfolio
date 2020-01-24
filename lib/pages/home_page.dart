import 'package:flutter/material.dart';

import '../components/carousel_slider.dart';

import '../constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 5,
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
            top: 110,
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
              child: CarouselSlider(
                items: <Widget>[
                  Container(
                    height: 0.8 * (MediaQuery.of(context).size.height - 150),
                    child: Image.asset("images/test_pic.png"),
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 0.8 * (MediaQuery.of(context).size.height - 150),
                    child: Image.asset("images/test_pic.png"),
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 0.8 * (MediaQuery.of(context).size.height - 150),
                    child: Image.asset("images/test_pic.png"),
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 0.8 * (MediaQuery.of(context).size.height - 150),
                    child: Image.asset("images/test_pic.png"),
                    color: Colors.transparent,
                  ),
                ],
                autoPlay: true,
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
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {},
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

import 'dart:math';

import 'package:flutter/material.dart';

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
                    child: ClipOval(
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: Image.asset(
                          'images/personal_photo.jpg',
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
                          "Ali Elganzory",
                          style: TextStyle(
                            fontSize: 40,
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
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text("data"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text("data"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text("data"),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

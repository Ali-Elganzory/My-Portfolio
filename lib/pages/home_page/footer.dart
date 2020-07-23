import 'package:flutter/material.dart';

import 'package:portfolio/constants/colors.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
    @required this.sh,
    @required this.sw,
  }) : super(key: key);

  final double sh;
  final double sw;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
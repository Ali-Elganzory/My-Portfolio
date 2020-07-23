import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/providers/carousels.dart';

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
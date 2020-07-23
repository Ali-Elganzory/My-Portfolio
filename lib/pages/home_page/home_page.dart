import 'package:flutter/material.dart';

import 'package:portfolio/constants/colors.dart';

import './header.dart';
import './gallery.dart';
import './footer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Container(
        height: sh,
        width: sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //  Header
            Header(sh: sh, sw: sw),
            //  Gallery
            Expanded(
              child: Gallery(sh: sh, sw: sw),
            ),
            //  Footer
            Footer(sh: sh, sw: sw),
          ],
        ),
      ),
    );
  }
}


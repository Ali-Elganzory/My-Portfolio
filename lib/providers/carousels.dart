import 'package:flutter/material.dart';

import '../components/carousel_slider.dart';

class CarouselsProvider with ChangeNotifier {
  static int appsCount = 4;
  static List<int> appScreensCount = [4, 4, 4, 4];

  int selectedAppIndex = 0;

  static final GlobalKey<CarouselSliderState> appsCarouselKey = GlobalKey();
  static final List<GlobalKey<CarouselSliderState>> screensCarouselKeys =
      List.generate(
    appsCount,
    (index) {
      return GlobalKey();
    },
  );

  void selectApp(int index) {
    selectedAppIndex = index;
    notifyListeners();
  }

  static List<IconData> appsIcons = [
    Icons.ac_unit,
    Icons.access_alarms,
    Icons.account_balance,
    Icons.adb,
  ];

  static List<List<Widget>> appScreens = [
    [
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
    ],
    [
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
    ],
    [
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
    ],
    [
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
      Image.asset("assets/test_pic.png"),
    ],
  ];
}

/* import 'package:flutter/material.dart';

class _InheritedCarousels extends InheritedWidget {
  final CarouselsProviderState data;

  _InheritedCarousels({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedCarousels oldWidget) => true;
}

class CarouselsProvider extends StatefulWidget {
  final Widget child;
  final data;

  const CarouselsProvider({
    Key key,
    @required this.child,
    this.data,
  }) : super(key: key);

  static CarouselsProviderState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(
            aspect: _InheritedCarousels) as _InheritedCarousels)
        .data;
  }

  @override
  CarouselsProviderState createState() => CarouselsProviderState();
}

class CarouselsProviderState extends State<CarouselsProvider> {
  int appsCount = 4;
  List<int> appScreensCount = [4, 4, 4, 4];

  final GlobalKey appsCarouselKey = GlobalKey();
  List<GlobalKey> screensCarouselKeys;
  @override
  void initState() {
    super.initState();
    screensCarouselKeys = List.generate(
      appsCount,
      (index) {
        return GlobalKey();
      },
    );
  }

  List<List<Widget>> appScreens = [
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

  @override
  Widget build(BuildContext context) {
    return _InheritedCarousels(
      data: this,
      child: widget.child,
    );
  }
}
 */

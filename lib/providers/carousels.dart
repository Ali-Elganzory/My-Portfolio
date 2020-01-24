import 'package:flutter/material.dart';

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
  final String user;

  const CarouselsProvider({
    Key key,
    @required this.child,
    this.user,
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
  @override
  Widget build(BuildContext context) {
    return _InheritedCarousels(
      data: this,
      child: widget.child,
    );
  }
}

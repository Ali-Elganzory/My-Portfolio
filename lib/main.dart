import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/home_page.dart';

void main() {
  //  show painting for debugging
  debugPaintSizeEnabled = false;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: HomePage(),
    );
  }
}

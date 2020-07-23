import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import './providers/carousels.dart';

import 'pages/home_page/home_page.dart';

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
      title: "Ali Elganzory",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CarouselsProvider>(
            create: (_) => CarouselsProvider(),
          ),
        ],
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

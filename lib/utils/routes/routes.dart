import 'package:flutter/material.dart';

import '../../ui/home_screen.dart';

class Routes {
  Routes._();

  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomeScreen(),
  };
}

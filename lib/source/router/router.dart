import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:susu/source/pages/Auth/login.dart';
import 'package:susu/source/pages/Auth/splashScreen.dart';
import 'package:susu/source/pages/Home/home.dart';
import 'package:susu/source/router/string.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => Login());
      case HOME:
        return MaterialPageRoute(builder: (context) => Home());
      default:
        return null;
    }
  }
}

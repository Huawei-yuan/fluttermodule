
//抽离整个APP的路由
import 'package:flutter/material.dart';
import 'package:fluttermodule/pages/HomePage.dart';
import 'package:fluttermodule/pages/SecondPage.dart';

class AppRoutes {
   static final Map<String, WidgetBuilder> routes = {
     RouteKeys.home: (context) => HomePage(),
     RouteKeys.secondPage: (context) => SecondPage(),
   };

   static WidgetBuilder? getPageBuilder(String routeName) {
     return routes[routeName];
   }
}

class RouteKeys {
  static const String home = '/home';
  static const String secondPage = '/secondPage';
}
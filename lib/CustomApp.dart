
import 'package:flutter/material.dart';
import 'package:fluttermodule/AppRoutes.dart';
import 'package:fluttermodule/Loger/AppLoger.dart';
import 'package:fluttermodule/beans/User.dart';
import 'package:fluttermodule/pages/HomePage.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'dart:ui' as ui;

import 'Actions.dart';
import 'AppStates.dart';
import 'Reducers.dart';

///自定义APP类，用于封装应用程序的启动和路由逻辑，以及Redux
class CustomApp extends StatelessWidget {

  final Store<AppState> appStore = Store(
      appReducers,
      initialState: AppState(
        user: User(id: "", name: "", gender: 1, age: 10),
        data: []
      ),
    middleware: [thunkMiddleware]
  );

  @override
  Widget build(BuildContext context) {
    // *ModalRoute.of(context)?.settings.arguments?.toString()*/
    String initialRoute = ui.window.defaultRouteName;
    String? routeName = null;
    String? paramsStr = null;
    int index = initialRoute?.indexOf('?') ?? 0;
    if (index > 0) {
      routeName = initialRoute?.substring(0, index);
      paramsStr = initialRoute?.substring(index + 1);
    }
    routeName ??= RouteKeys.home;
    loger.i("initialRoute: $initialRoute"
        "，routeName = $routeName"
        ", paramsStr = $paramsStr");

    final WidgetBuilder? initialWigetBuilder = AppRoutes.getPageBuilder(routeName);
    loger.i("initialWidgetBuilder: $initialWigetBuilder");

    final Widget initialPage = initialWigetBuilder != null ? initialWigetBuilder(context) : HomePage();
    loger.i("initialPage: $initialPage");

    return StoreProvider<AppState>(
      store: appStore,
      child: MaterialApp(
        title: "Flutter Redux Demo",
        theme: ThemeData.light(useMaterial3: true), //主题
        home: initialPage,
        routes: AppRoutes.routes,
      ),
    );
  }

}
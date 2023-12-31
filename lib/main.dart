import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermodule/CustomApp.dart';
import 'package:fluttermodule/customwidgets/FlutterWidget.dart';
import 'package:fluttermodule/customwidgets/MultiShower.dart';
import 'package:fluttermodule/customwidgets/TodoList.dart';

import 'pages/GetBuilderPage.dart';
import 'pages/ObxLogicPage.dart';
import 'customwidgets/ItemChart.dart';
import 'customwidgets/TextSlider.dart';
import 'customwidgets/TweenAnimPath.dart';
import 'customwidgets/UserPanel.dart';
import 'http/TestHttp.dart';
import 'redux/ReduxExample.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(CustomApp());
}

Widget getRouter(String routeName) {
  switch (routeName) {
    case 'main':
      return const MyApp();
    case 'reduxMain':
      return FlutterReduxApp(
        store: Store<int>(countReducer, initialState: 0),
        title: "Flutter Redux Demo",
      );
    default:
      return MaterialApp(
        title: 'Flutter GetBuilderPage',
        home: Scaffold(
            appBar: AppBar(title: const Text('Flutter Widget Animation')),
            body: TodoList()/*Column(
              children: [
                MultiShower(
                  const [
                    AnimConfig(1000, 10, RockMode.random),
                    AnimConfig(1000, 10, RockMode.up_down),
                    AnimConfig(1000, 10, RockMode.left_right),
                    AnimConfig(1000, 10, RockMode.lean)
                  ],
                      (config) => FlutterWidget(
                    animConfig: config,
                    child: ClipOval(
                        child: Image.network(
                          "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        )),
                  ),
                  infos: ["random", "up_down", "left_right", "lean"],
                  width: 60,
                  height: 60,
                ),


                MultiShower(
                  [
                      CurveTween(curve: Curves.bounceIn),
                      CurveTween(curve: Curves.bounceInOut),
                      CurveTween(curve: Curves.bounceOut),
                      CurveTween(curve: Curves.decelerate),
                      CurveTween(curve: Curves.ease),
                      CurveTween(curve: Curves.easeIn),
                      // CurveTween(curve: Curves.easeInBack),
                      // CurveTween(curve: Curves.easeInCirc),
                      // CurveTween(curve: Curves.easeInCubic),
                      // CurveTween(curve: Curves.easeInExpo),
                      // CurveTween(curve: Curves.easeInOut),
                      // CurveTween(curve: Curves.easeInOutBack),
                      // CurveTween(curve: Curves.easeOut),
                      // CurveTween(curve: Curves.easeOutBack),
                      // CurveTween(curve: Curves.linear),
                      // CurveTween(curve: Curves.linearToEaseOut),
                  ],
                      (curve) => FlutterWidget(
                    animConfig: AnimConfig(1000, 30, RockMode.lean, curveTween: curve),
                    child: ClipOval(
                        child: Image.network(
                          "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        )),
                  ),
                  infos: const ["bounceIn","bounceInOut","bounceOut","decelerate",
                    "ease","easeIn"/*,"easeInBack","easeInCirc","easeInCubic",
                    "easeInExpo","easeInOut","easeInOutBack",
                    "easeOut","easeOutBack","linear","linearToEaseOut"*/],
                  width: 60,
                  height: 60,
                ),
                TextSider(),
                ItemChart(chartBean: ChartBean(
                    image: "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                  name: "张风捷特烈",
                  sentence: "我就是我, 是不一样的烟火",
                  time: "2小时前",
                  shield: false
                ),
                  onTap: (bean) {
                    print("onTap: $bean");
                  },
                ),

                UserPanel(
                  userInfo: UserInfo(
                    name: "张风捷特烈",
                    level: 16,
                    image: "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                    post: "前端工程师",
                    company: "腾讯",
                    proverbs: "我就是我, 是不一样的烟火",
                  ),
                  editCallback: () {
                    print("On Edit click");
                  }
                )
              ],
            )*/) /* FlutterWidget(
            animConfig: const AnimConfig(2000, 15, RockMode.up_down),
            child: ClipOval(
              child: Image.network(
                "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
        ) TweenAnimPage() GetBuilderPage() ObxLogicPage(), GetBuilderPage()*/
        ,
      );
    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Flutter Demo Home Page'),
    //     ),
    //     body: const Center(
    //       child: Text(
    //         "page not found",
    //         style: TextStyle(
    //             fontSize: 24,
    //             color: Colors.red
    //         ),
    //       ),
    //     ),
    //   )
    // );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _channel =
      const MethodChannel('com.hw.demo.androidandflutterinteractive');

  dynamic _electricity;
  final _eventChannel = const EventChannel(
      "com.hw.demo.androidandflutterinteractive.eventchannel");
  StreamSubscription? _eventSubscription;

  dynamic _content;
  final _messageChannel = const BasicMessageChannel(
      "com.hw.demo.androidandflutterinteractive.messagechannel", StringCodec());

  @override
  void initState() {
    _channel.setMethodCallHandler((call) async {
      String method = call.method;
      dynamic arguments = call.arguments;
      print("MethodCallHandler: $method, arguments: $arguments");
      switch (method) {
        case 'timer':
          setState(() {
            _counter = call.arguments["count"];
          });
          if (_counter == 5) {
            _channel.invokeMethod("sendFinish");
          }
          break;
      }
    });

    _eventSubscription = _eventChannel
        .receiveBroadcastStream(["Hello,建立EventChannel链接吧！！！"]).listen(_onData,
            onError: _onError, onDone: _onDone);

    _messageChannel.setMessageHandler((message) => Future<String>(() {
          print("BasicMessageChannel: $message");
          setState(() {
            _content = message;
          });
          return "好啊";
        }));
    super.initState();
  }

  void _onData(event) {
    print("_onData event = $event");
    setState(() {
      _electricity = event;
    });
  }

  void _onError(error) {
    print("_onError error = $error");
  }

  void _onDone() {
    print("_onDone _onDone");
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void dispose() {
    if (_eventSubscription != null) {
      _eventSubscription?.cancel();
      _eventSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$_electricity',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '$_content',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

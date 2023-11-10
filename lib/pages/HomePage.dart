import 'package:flutter/material.dart';
import 'package:fluttermodule/customwidgets/AbilityWidget.dart';

//主页面
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const Center(
        child: AbilityWidget(),
      )
    );
  }
}

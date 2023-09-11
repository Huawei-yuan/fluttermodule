
//主页面
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Second Page'),
      ),
      body: const Center(
        child: Text(
          "Second Page",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
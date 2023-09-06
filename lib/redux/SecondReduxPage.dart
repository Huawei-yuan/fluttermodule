
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SecondReduxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondReduxPage'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: StoreConnector<int, String>(
          converter: (Store<int> store) {
            return store.state.toString();
          },
          builder: (context, count) {
            return Text(
              count.toString(),
              style: const TextStyle(fontSize: 30),
            );
          },
        )
      ),
    );
  }
  
}
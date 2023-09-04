import 'package:flutter/material.dart';

class TextSider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextSiderState();
  }
}

class _TextSiderState extends State<TextSider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildText(_value),
        _buildSider(_value)
      ]
    );
  }

  Widget _buildText(double value) {
    return Text(value.toStringAsFixed(2),
    style: const TextStyle(fontSize: 20),);
  }

  Widget _buildSider(double value) {
    return Slider(
        value: value,
        min: 0,
        max: 100,
        onChanged: (progress) {
          print("onChanged: $progress");
          _render(progress);
        },
        onChangeStart: (progress) {
          print("onChangeStart: $progress");
        },
        onChangeEnd: (progress) {
          print("onChangeEnd: $progress");
        });
  }

  void _render(double progress) {
    _value = progress;
    setState(() {});
  }
}

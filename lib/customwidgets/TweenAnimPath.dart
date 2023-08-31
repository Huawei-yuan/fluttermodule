import 'dart:ui';

import 'package:flutter/material.dart';

///Tween动画Widget
class TweenAnimPage extends StatefulWidget {
  const TweenAnimPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TweenAnimPageState();
  }
}

///Tween动画Widget State
class TweenAnimPageState extends State<TweenAnimPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  List<Offset> _points = [];

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
    var tween = Tween(begin: -150.0, end: 150.0);
    _animation = tween.animate(_controller);
    _animation.addListener(() {
      _render(_points, _animation.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Tween Aniation"),
      ),
      body: CustomPaint(
          painter: AnimView(_points),
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    if(_controller.isAnimating) {
    return;
    }
    if(_controller.isCompleted) {
    _controller.reverse();
    } else {
    _controller.forward();
    }
    },
    tooltip: "Increament",
    child: const Icon(Icons.add),
    ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double x = 0;

  //核心渲染方法,将值加入集合中并渲染
  void _render(List<Offset> points, double value) {
    _points.add(Offset(x, value.roundToDouble()));
    x += 2;
    setState(() {

    });
  }
}

class AnimView extends CustomPainter {

  List<Offset> _points;
  late Paint _paint;
  late Paint _gridPaint;

  AnimView(this._points) {
    _paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.deepOrange
      ..strokeWidth=3;
    _gridPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..color = Colors.cyanAccent;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //画网格
    canvas.drawPath(gridPath(area: const Size(500, 1000)), _gridPaint);
    canvas.translate(200, 200);
    canvas.drawCircle(const Offset(0, 0), 2.5, _gridPaint..color=Colors.black..style=PaintingStyle.fill);
    _drawStar(canvas, _points);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  ///创建一个区域是[area]，小格边长为[step]的网格的路径
  Path gridPath({double step = 20, Size area = Size.zero}) {
    Path path = Path();
    for(int i = 0; i < area.height / step + 1; i++) {
      //画横线
      path.moveTo(0, i * step);
      path.lineTo(area.width, i * step);
    }

    for(int i = 0; i < area.width / step + 1; i++) {
      //画竖线
      path.moveTo(i * step, 0);
      path.lineTo(i * step, area.height);
    }
    return path;

  }

  void _drawStar(Canvas canvas, List<Offset> points) {
    canvas.drawPoints(PointMode.lines, points, _paint);
  }
}
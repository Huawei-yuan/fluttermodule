
import 'dart:math';

import 'package:flutter/material.dart';

///运动球动画widget
class RunBall extends StatefulWidget {
  const RunBall({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RunBallState();
  }
}

class _RunBallState extends State<RunBall> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  var _oldTime = DateTime.now().millisecondsSinceEpoch; //首次运行时间

  final _area = const Rect.fromLTRB(0 + 40, 0 + 200, 280 + 40, 200 + 200);
  // final _ball = Ball(color: Colors.blueAccent,  r: 10, x: 40 + 140, y: 200 + 100);
  final _ball = Ball(color: Colors.blueAccent, r: 10,aY: 0.1, vX: 2, vY: -2,x: 40.0+140,y:200.0+100);

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000 * 10),
      vsync: this
    );
    _controller.addListener(() {
      _render();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Scaffold(
      body: CustomPaint(
        painter: RunBallView(_ball, _area),
      ),
    );

    return GestureDetector(
      onTap: () {
        if(_controller.isAnimating) {
          return;
        }
        if(_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward(); //点击执行动画
        }
      },
      child: child
    );
  }

  void _render() {
    _updateBall();
    setState(() {
      var now = DateTime.now().millisecondsSinceEpoch;
      print("时间差：${now - _oldTime}");
      _oldTime = now;
    });
  }

  void _updateBall() {
    //运动学公式
    _ball.x += _ball.vX;
    _ball.y += _ball.vY;
    _ball.vX += _ball.aX;
    _ball.vY += _ball.aY;
    //限定下边界
    if (_ball.y > _area.bottom - _ball.r) {
      _ball.y = _area.bottom - _ball.r;
      _ball.vY = -_ball.vY;
      _ball.color = _randomRGB();//碰撞后随机色
    }
    //限定上边界
    if (_ball.y < _area.top + _ball.r) {
      _ball.y = _area.top + _ball.r;
      _ball.vY = -_ball.vY;
      _ball.color = _randomRGB();//碰撞后随机色
    }

    //限定左边界
    if (_ball.x < _area.left + _ball.r) {
      _ball.x = _area.left + _ball.r;
      _ball.vX = -_ball.vX;
      _ball.color = _randomRGB();//碰撞后随机色
    }

    //限定右边界
    if (_ball.x > _area.right - _ball.r) {
      _ball.x = _area.right - _ball.r;
      _ball.vX= -_ball.vX;
      _ball.color = _randomRGB();//碰撞后随机色
    }
  }

  Color _randomRGB() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // 0-255 for red
      random.nextInt(256), // 0-255 for green
      random.nextInt(256), // 0-255 for blue
      1.0, // 1.0 for alpha (fully opaque)
    );
  }
}

///小球信息描述类
class Ball {
  double aX; //加速度
  double aY; //加速度Y
  double vX; //速度X
  double vY; //速度Y
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r;//小球半径

  Ball({this.x=0, this.y=0, required this.color, this.r=10,
    this.aX=0, this.aY=0, this.vX=0, this.vY=0});
}

///画板Painter
class RunBallView extends CustomPainter {

  Ball _ball; //小球
  Rect _area; //运动区域
  late Paint _paint; //主画笔
  late Paint _bgPaint; //背景画笔

  RunBallView(this._ball, this._area) {
    _paint = Paint()..isAntiAlias = true;
    _bgPaint = Paint()..isAntiAlias = true
      ..color = const Color.fromARGB(148, 198, 246, 248);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_area, _bgPaint);
    _drawBall(canvas, _ball);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawBall(Canvas canvas, Ball ball) {
    canvas.drawCircle(Offset(ball.x, ball.y), ball.r, _paint..color = ball.color);
  }
  
}
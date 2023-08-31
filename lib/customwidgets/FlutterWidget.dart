
import 'dart:math';

import 'package:flutter/material.dart';

///FluterWidget的震动模式
enum RockMode {
  random,//随机
  up_down,//上下
  left_right,//左右
  lean //倾斜
}

///FutterWidget的震动配置
class AnimConfig {
  final int duration; //时长
  final double offset;//偏移大小
  final RockMode rockMode; //震动模式
  final CurveTween? curveTween;//运动曲线
  const AnimConfig(this.duration, this.offset, this.rockMode, {this.curveTween});
}


///颤动动画
class FlutterWidget extends StatefulWidget {

  AnimConfig animConfig;
  Widget child;

  FlutterWidget({
    super.key,
    this.child = const Text("Flutter"),
    this.animConfig = const AnimConfig(1000, 15, RockMode.left_right)});


  @override
  State<StatefulWidget> createState() {
    return _FlutterWidgetState();
  }
}

class _FlutterWidgetState extends State<FlutterWidget> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animConfig.duration),
      vsync: this
    );

    var dx = widget.animConfig.offset;
    var curveTween = widget.animConfig.curveTween;
    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: dx), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: dx, end: 0), weight: 2),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -dx), weight: 3),
      TweenSequenceItem<double>(tween: Tween(begin: -dx, end: 0), weight: 4)
    ]).animate(curveTween == null ? _controller : curveTween.animate(_controller));
    _animation.addStatusListener((status) {
      print("_FlutterWidgetState _animation onStatusChange status: $status");
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_controller.isAnimating) {
          return;
        }
        if(_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child:  FlutterAnim(widget.child, _animation, widget.animConfig),
    );
  }
}

class FlutterAnim  extends StatelessWidget {

  final Widget child;
  final Animation<double> animation;
  final AnimConfig animConfig;

  const FlutterAnim(this.child, this.animation, this.animConfig, {super.key});

  Random get random => Random();

  @override
  Widget build(BuildContext context) {
    var result = AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
              transform: _formTransForm(animConfig),
            alignment: Alignment.center,
            child: this.child,
          );
        }
    );

    return Center(
      child: result,
    );
  }

  _formTransForm(AnimConfig animConfig) {
    var result;
    switch (animConfig.rockMode) {
      case RockMode.random:
        result = Matrix4.rotationZ(animation.value  * pow(-1, random.nextInt(20)) * pi / 180);
        break;
      case RockMode.left_right:
        result = Matrix4.translationValues(animation.value * pow(-1, random.nextInt(20)), 0, 0);
        break;
      case RockMode.up_down:
        result = Matrix4.translationValues(0, animation.value * pow(-1, random.nextInt(20)), 0);
        break;
      case RockMode.lean:
        result = Matrix4.rotationZ(animation.value * pi / 180);
        break;
    }
    return result;
  }
}
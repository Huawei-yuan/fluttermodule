import 'dart:math';

import 'package:flutter/material.dart';

/// 需要的知识点:Flutter中的手势交互,主要是移动相关
/// 1.一条线是点的集合,绘板需要画n条线，所以是点的集合的集合 _lines
/// 2.组件为有状态组件,_lines为状态量,在移动时将点加入当前所画的线
/// 3.当抬起时说明一条线完毕，应该拷贝入_lines,并清空当前线作为下一条
/// 4.绘制单体类有颜色，大小，位置三个属性,类名TolyCircle
///
/// 作者：张风捷特烈
/// 链接：https://juejin.cn/post/6844903889871831053
/// 来源：稀土掘金
/// 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
///
///

class TolyDrawable {
  Color color; //颜色
  Offset pos; //位置
  TolyDrawable(this.color, this.pos);
}

///绘制触点类
class TolyCircle extends TolyDrawable {
  double radius; //半径大小
  TolyCircle(super.color, super.pos, {this.radius = 1});
}

///画板类
class Paper extends CustomPainter {

  Paper(@required this.lines);

  final Paint _paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  List<List<TolyCircle>> lines;

  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    for(int i = 0; i < lines.length; i++) {
      drawLines(canvas, lines[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  ///根据点位绘制线
  void drawLines(Canvas canvas, List<TolyCircle> positions) {
    print("drawLines positions = $positions");
    for(int i = 0; i < positions.length - 1; i++) {
      if(positions[i] != null && positions[i + 1] != null) {
        canvas.drawLine(positions[i].pos, positions[i + 1].pos,
            _paint..strokeWidth = positions[i].radius
                  ..color = positions[i].color);
      }
    }
  }
}

class TolyCanvas extends StatefulWidget {
  const TolyCanvas({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TolyCanvasState();
  }
}

class _TolyCanvasState extends State<TolyCanvas> {

  final _positions = <TolyCircle>[];
  final _lines = <List<TolyCircle>>[];
  Offset? _oldPos; //记录上一点

  @override
  Widget build(BuildContext context) {
     var body = CustomPaint(
       painter: Paper(_lines),
     );

     var scaffold = Scaffold(
       body: body
     );

     var result = GestureDetector(
       onPanDown: _panDown,
       onPanUpdate: _panUpdate,
       onPanEnd: _panEnd,
       onDoubleTap: () {
         _lines.clear();
         _render();
       },
       child: scaffold,
     );

     return result;
  }

  /// 按下时表示新添加一条线,并记录上一点位置
  void _panDown(DragDownDetails details) {
    print("panDown details = $details");
    _lines.add(_positions);

    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    _oldPos = Offset(x, y);
  }

  ///移动中，将点添加到点集中
  void _panUpdate(DragUpdateDetails details) {
    print("panUpdate details = $details");
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    var curPos = Offset(x, y);

    if(_oldPos != null && (curPos - _oldPos!).distance > 3) {
      var len =  (curPos - _oldPos!).distance;
      var width =40* pow(len,-1.2);//TODO 处理不够顺滑，待处理
      var tolyCirlce = TolyCircle(Colors.blue, curPos, radius: width.toDouble());
      _positions.add(tolyCirlce);
      _oldPos = curPos;
      _render();
    }
  }

  /// 抬起后，将旧线拷贝到线集中
  void _panEnd(DragEndDetails details) {
    var oldBall = <TolyCircle>[];
    oldBall.addAll(_positions);
    _lines.add(oldBall);
    _positions.clear();
  }

  ///渲染方法，将重新渲染组件
  void _render() {
    setState(() {

    });
  }
}


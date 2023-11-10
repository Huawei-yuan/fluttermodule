import 'dart:math';

import 'package:flutter/material.dart';

///一个类似指南针的蜘蛛网组件
class AbilityWidget extends StatefulWidget {
  const AbilityWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AbilityWidgetState();
  }

}

class _AbilityWidgetState extends State<AbilityWidget> {
  @override
  Widget build(BuildContext context) {
    var paint = CustomPaint(
      painter: AbilityPainter(),
    );
    return SizedBox(
      width: 200,
      height: 200,
      child: paint,
    );
  }
}

class AbilityPainter extends CustomPainter {
  var data = {
    "攻击力": 70.0,
    "生命": 90.0,
    "闪避": 50.0,
    "暴击": 70.0,
    "破格": 80.0,
    "格挡": 100.0,
  };

  double radius = 100; //外圆半径
  late Paint linePaint; //线画笔
  late Paint abilityPaint; //区域画笔
  late Paint fillPaint; //填充画笔

  late Path linePath; //短直线路径
  late Path abilityPath; //范围路径

  AbilityPainter() {
    linePath = Path();
    abilityPath = Path();
    linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.008 * radius
      ..isAntiAlias = true;

    fillPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0.05 * radius
      ..isAntiAlias = true;

    abilityPaint = Paint()
      ..color = const Color(0x8897C5FE)
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //先移动坐标系到圆心
    canvas.translate(radius, radius);
    //画外圆
    drawOutCircle(canvas);
    //画内圆
    drawInnerCircle(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  ///画外圆
  void drawOutCircle(Canvas canvas) {
    canvas.save();//新建图层
    canvas.drawCircle(const Offset(0, 0), radius, linePaint);//外圈圆形绘制
    double r2 = radius - 0.08 * radius;//内圈半径
    canvas.drawCircle(const Offset(0, 0), r2, linePaint);//内圈圆形绘制
    for(var i = 0.0; i < 22; i++) { //循环画出内圆外圆中间的分段小黑条
      canvas.save(); //新建图层
      canvas.rotate(i * 360 / 22 * pi); //旋转到指定角度 注意传入的是弧度（与Android不同）
      canvas.drawLine(Offset(0, -radius), Offset(0, -r2), fillPaint); //线的绘制
      canvas.restore(); //恢复图层
    }

    canvas.restore();//恢复图层
  }

  ///画内圆
  void drawInnerCircle(Canvas canvas) {
    double innerRadius = 0.618 * radius; //内圆半径
    canvas.save();//新建图层
    canvas.drawCircle(const Offset(0, 0), innerRadius, linePaint);

    for(var i = 0; i < 6; i++) { //绘制内圆内部的六条线
      canvas.save(); //新建图层
      canvas.rotate(60 * i / 180 * pi);//每次旋转60度
      linePath.moveTo(0, -innerRadius);//移动到内圆边上起点
      linePath.relativeLineTo(0, innerRadius);//绘制内圆半径线
      canvas.drawPath(linePath, linePaint);

      for(int j = 0; j < 6; j++) { //绘制每条半径线的刻度
        linePath.moveTo(-radius * 0.02, innerRadius / 6 * j);
        linePath.relativeLineTo(radius * 0.02 * 2, 0);
      }

      canvas.restore();
    }

    canvas.restore();
  }
}

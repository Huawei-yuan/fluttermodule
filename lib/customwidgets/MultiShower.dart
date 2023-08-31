
import 'package:flutter/material.dart';

class MultiShower extends StatelessWidget {

  const MultiShower(
      this.list,
      this.call,{super.key,
        this.width = 100.0,
        this.height = 100 * 0.618,
        this.infos,
        this.color = Colors.cyanAccent
      });

  final List list;
  final List<String>? infos;
  final Function call;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var li = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      var child = Container(
        margin: const EdgeInsets.all(7),
        width: width, 
        height: height,
        color: color,
        child: call(list[i]),
      );
      li.add(
        Column(
          children: [
            child,
            Text((infos != null && i < infos!.length) ? infos![i] : ""),
          ],
        )
      );
    }
    return Wrap(
      children: li
    );
  }

}
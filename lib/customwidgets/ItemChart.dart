import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

typedef TapCallbck = void Function(ChartBean bean);

///仿微信条目封装
class ItemChart extends StatefulWidget {

  final ChartBean chartBean;//条目描述

  final TapCallbck onTap;

  const ItemChart({required this.chartBean, required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _ItemChartState();
  }
}

class _ItemChartState extends State<ItemChart> {

  var nameTextStyle = const TextStyle(color: Colors.black, fontSize: 15);
  var infoTextStyle = const TextStyle(color: Colors.grey, fontSize: 12);

  bool _checked = false;//是否已查看


  @override
  Widget build(BuildContext context) {
    var lefthead = Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(widget.chartBean.image, fit: BoxFit.cover),
      ),
    );

    var leftWrap = Stack(
      alignment: const Alignment(1.2, -1.2),
      children: [
        lefthead,
        ClipOval(
            child: Container(
              color: Colors.red,
              width: 10,
              height: 10,
            )
        )
      ]
    );

    var center = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.chartBean.name, style: nameTextStyle),
        Padding(padding: const EdgeInsets.only(top: 5),
            child: Text(widget.chartBean.sentence, style: infoTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis,)),
      ],
    );

    var right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.chartBean.time, style: infoTextStyle),
        widget.chartBean.shield ? const Icon(Icons.visibility_off, color: Colors.grey, size: 18) : Container(height: 18,),
      ],
    );

    var body = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(padding: EdgeInsets.only(right: 10), child: _checked ? lefthead : leftWrap,),
        Expanded(child: center),
        right
      ]
    );

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        child: body,
      ),
      onTap: () {
        _checked = !_checked;
        if(widget.onTap != null){
          widget.onTap(widget.chartBean);
        }
        setState(() {

        });
      },
    );
  }
}

class ChartBean {
  String image; //头像
  String name; //昵称
  String sentence; //句子
  String time; //时间
  bool shield; //是否屏蔽

  ChartBean(
      {required this.image,
      required this.name,
      required this.sentence,
      required this.time,
      this.shield = false});
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/Loger/AppLoger.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 一个各种对话框展示组件
class DialogShow extends StatefulWidget {
  const DialogShow({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DialogShowState();
  }
}

class _DialogShowState extends State<DialogShow> {
  @override
  Widget build(BuildContext context) {
    var title = Container(
      alignment: AlignmentDirectional.center,
      child: const Text(
        "Dialog unit",
        style: TextStyle(fontSize: 28),
      ),
    );

    Map<String, Function> buttons = {
      "SimpleDialog": _showSimpleDialog,
      "AlertDialog": _showAlertDialog,
      "CupertinoAlertDialog": _showCupertinoAlertDialog,
      "对话框显示自己": _showWidgetDialog,
      "对话框显示StatefulWidget": _showStatefulWidgetDialog,
      "Scaffold": _showScaffold,
      "BottomSheet": _showBottomSheet,
      "DatePicker": _showDatePicker,
      "TimePicker": _showTimePicker,
      "CupertinoPicker": _showCupertinoPicker,
      "CupertinoDatePicker": _showCupertinoDatePicker,
      "CupertinoTimerPicker": _showCupertinoTimerPicker,
    };

    var btns = buttons.keys
        .map((key) => ElevatedButton(
            onPressed: () {
              buttons[key]!(context);
            },
            child: Text(key)))
        .toList();

    return Column(
      children: [title, ...btns],
    );
  }
}

_showSimpleDialog(BuildContext context) {
  loger.d("_showSimpleDialog context= $context");

  final title = Row(children: [
    Image.asset(
      "assets/images/default_head.png",
      width: 30,
      height: 30,
    ),
    const SizedBox(width: 10),
    const Text("SimpleDialog"),
  ]);

  const strs = [
    '云深不知处内亥时息,卯时起',
    "云深不知处内不可挑食留剩,不可境内杀生",
    "云深不知处内不可私自斗殴,不可淫乱",
    "云深不知处禁止魏无羡入内,不可吹笛"
  ];

  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: title,
          children: strs
              .map((e) => SimpleDialogOption(
                    onPressed: () {
                      loger.d("on $e Click");
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.turned_in_outlined),
                        Expanded(child: Text(e))
                      ],
                    ),
                  ))
              .toList(),
        );
      });
}

_showAlertDialog(BuildContext context) {
  loger.d("_showAlertDialog context= $context");
  final title = Row(children: [
    Image.asset(
      "assets/images/default_head.png",
      width: 30,
      height: 30,
    ),
    const SizedBox(width: 10),
    const Text("SimpleDialog"),
  ]);

  var content = Row(
    //内容
    children: <Widget>[
      Text("我💖你，你是我的"),
      SvgPicture.asset(
        "assets/svg/icon_lipstick.svg",
        width: 30,
        height: 30,
      )
    ],
  );

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: title,
            content: content,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    loger.d("on 不要闹 Click");
                    Navigator.of(context).pop();
                  },
                  child: const Text("不要闹")),
              ElevatedButton(
                  onPressed: () {
                    loger.d("on 走开 Click");
                    Navigator.of(context).pop();
                  },
                  child: const Text("走开"))
            ],
          ));
}

_showCupertinoAlertDialog(BuildContext context) {
  loger.d("_showCupertinoAlertDialog context= $context");
  final title = Row(children: [
    Image.asset(
      "assets/images/default_head.png",
      width: 30,
      height: 30,
    ),
    const SizedBox(width: 10),
    const Text("SimpleDialog"),
  ]);

  var content = Row(
    //内容
    children: <Widget>[
      Text("我💖你，你是我的"),
      SvgPicture.asset(
        "assets/svg/icon_lipstick.svg",
        width: 30,
        height: 30,
      )
    ],
  );

  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              CupertinoButton(
                  onPressed: () {
                    loger.d("on 不要闹 Click");
                    Navigator.pop(context);
                  },
                  child: const Text("不要闹")),
              CupertinoButton(
                  onPressed: () {
                    loger.d("on 走开 Click");
                    Navigator.pop(context);
                  },
                  child: const Text("走开"))
            ],
          ));
}

_showWidgetDialog(BuildContext context) {
  loger.d("_showWidgetDialog context= $context");
  showDialog(context: context, builder: (context) => const DialogShow());
}

_showStatefulWidgetDialog(BuildContext context) {
  loger.d("_showStatefulWidgetDialog context= $context");
  var progress = 0.0;
  StateSetter? stateSetter;

  Timer.periodic(Duration(milliseconds: 100), (timer) {
    progress += 0.1;
    if (stateSetter != null) {
      stateSetter!(() {});
    }

    if (progress >= 1.0) {
      timer.cancel();
      stateSetter = null;
      Navigator.pop(context);
    }
  });

  var statefulBuilder = StatefulBuilder(builder: (context, state) {
    stateSetter = state;
    return Center(
        child: SizedBox(
      width: 150,
      height: 150,
      child: Card(
        elevation: 24.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Loading",
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              "Done ${((progress - 0.1) * 100).toStringAsFixed(1)}%",
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    ));
  });

  showDialog(context: context, builder: (ctx) => statefulBuilder);
}

_showScaffold(BuildContext context) {
  loger.d("_showScaffold context= $context");
  SnackBar snackBar = SnackBar(
    content: const Text("Hello"),
    backgroundColor: Colors.teal,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(label: "确定", onPressed: () {
      loger.d("on 确定 Click");
    }),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

bool _bottomSheetIsShowing = false;

_showBottomSheet(BuildContext context) {
  loger.d("_showBottomSheet context= $context");
  var bottomSheet = BottomSheet(onClosing: (){
     loger.d("BottomSheet onClosing");
  }, builder: (context) => Container(
    color: Colors.orange,
    height: 200,
    child: Center(
      child: Image.asset("assets/images/pic_hole.png"),
    ),
  ));

  if(!_bottomSheetIsShowing){
    Scaffold.of(context).showBottomSheet(bottomSheet.builder);
  } else {
    Navigator.of(context).pop();
  }
  _bottomSheetIsShowing = !_bottomSheetIsShowing;

}

_showDatePicker(BuildContext context) {
  loger.d("_showDatePicker context= $context");
  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(data: ThemeData.dark(), child: Center(child: child,));
    }
  ).then((value) {
    loger.d("showDatePicker value= $value");
  });
}

_showTimePicker(BuildContext context) {
  loger.d("_showTimePicker context= $context");
  showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: Center(child: child,));
      }
  ).then((value) {
    loger.d("showTimePicker value= $value");
  });
}

_showCupertinoPicker(BuildContext context) {
  loger.d("_showCupertinoPicker context= $context");
  var names=['魏祖','蓝二','江姐','江舅','瑶妹'];
  final picker = CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (position) {
        loger.d("onSelectedItemChanged position= $position");
      },
      children: names.map((e) => Text(e)).toList());
  
  showCupertinoModalPopup(context: context, builder: (context) {
    return Container(
      height: 200,
      child: picker,
    );
  });
}

_showCupertinoDatePicker(BuildContext context) {
  loger.d("_showCupertinoDatePicker context= $context");
  final picker = CupertinoDatePicker(
      itemExtent: 40,
      onDateTimeChanged: (date) {
        loger.d("onDateTimeChanged date= $date");
      },
      initialDateTime: DateTime.now(),);

  showCupertinoModalPopup(context: context, builder: (context) {
    return SizedBox(
      height: 200,
      child: picker,
    );
  });
}

_showCupertinoTimerPicker(BuildContext context) {
  loger.d("_showCupertinoTimerPicker context= $context");
  final picker = CupertinoTimerPicker(
    itemExtent: 40,
    onTimerDurationChanged: (duration) {
      loger.d("onTimerDurationChanged duration= $duration");
    },);

  showCupertinoModalPopup(context: context, builder: (context) {
    return SizedBox(
      height: 200,
      child: picker,
    );
  });
}

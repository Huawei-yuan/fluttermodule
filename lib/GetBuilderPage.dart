import 'package:flutter/material.dart';
import 'package:fluttermodule/customwidgets/MultiShower.dart';
import 'package:get/get.dart';

import 'customwidgets/handDrawnBoard/HandDrawnBoard.dart';

class GetBuilderLogic extends GetxController {
  var count = 0;

  void increase() {
    count++;
    update();
  }
}

class GetBuilderPage extends StatelessWidget {
  GetBuilderPage({Key? key}) : super(key: key);

  //1.依赖注入
  final GetBuilderLogic logic = Get.put(GetBuilderLogic());

  final decorations = [
    TextDecoration.none,
    TextDecoration.lineThrough,
    TextDecoration.overline,
    TextDecoration.underline
  ];

  final fitModes = [
    BoxFit.none,
    BoxFit.contain,
    BoxFit.cover,
    BoxFit.fill,
    BoxFit.fitHeight,
    BoxFit.fitWidth,
    BoxFit.scaleDown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetBuilderPage'),
      ),
      //2. GetBuilder管理模式
      body: GetBuilder<GetBuilderLogic>(builder: (logic) {
        return Center(
          child: Column(children: [
            Text(
              "You tap FAB ${logic.count} times",
              style: const TextStyle(fontSize: 20),
            ),
            /*MultiShower(
                decorations,
                (type) => Text(
                      "张风捷特烈",
                      style: TextStyle(fontSize: 20, decoration: type),
                    )),
            MultiShower(
              fitModes,
              (mode) => Image.network(
                "https://img0.baidu.com/it/u=3310909096,3638950111&fm=253&fmt=auto&app=138&f=JPEG?w=300&h=200",
                fit: mode,
              ),
              width: 150,
              color: Colors.red,
            ),*/
             const SizedBox(
              width: 600,
              height: 500,
              child: TolyCanvas(),
            )
          ]),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.increase(),
        tooltip: "Increase Counter",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

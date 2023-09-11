
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObxLogic {
  var count = 0.obs;

  void increase() {
    count++;
  }
}

class ObxLogicPage extends StatelessWidget {
   ObxLogicPage({Key? key}) : super(key: key);
   //1、依赖注入
   final obxLogic = Get.put(ObxLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetBuilderPage'),
      ),
      //2. Obx管理模式
      body: Obx((){
        return Center(
          child: Text(
            "You tap FAB ${obxLogic.count} times",
            style: const TextStyle(fontSize: 20),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => obxLogic.increase(),
        tooltip: "Increase Counter",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
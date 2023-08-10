import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetBuilderLogic extends GetxController{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetBuilderPage'),
      ),
      //2. GetBuilder管理模式
      body: GetBuilder<GetBuilderLogic>(builder: (logic) {
        return Center(
          child: Text(
            "You tap FAB ${logic.count} times",
            style: const TextStyle(fontSize: 20),
          ),
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
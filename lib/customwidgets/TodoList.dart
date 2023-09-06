import 'package:flutter/material.dart';


///实现一个待办事项列表的widget
class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }

}

enum ShowType {
  all,  //所有
  todo, //未完成
  done  //已完成
}

class _TodoListState extends State<TodoList> {

  //用一个Map盛放文字和是否选中的
  var _todo = <String, bool>{};
  //当前输入的文字
  var _text;
  var _showType = ShowType.all;

  @override
  Widget build(BuildContext context) {
    //顶部输入框
    var textField = _creatTextField();
    //顶部添加按钮
    var addBtn = _creatAddBtn();
    //顶部栏
    var inputRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: textField,
          width: 200,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Container(
            child: addBtn,
            width: 36,
            height: 36,
          ),
        )
      ],
    );

    //中间三个按钮
    var buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: (){
              print("onButtonClick: 全部");
              _showType = ShowType.all;
              setState(() {

              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text("全部")),
        ElevatedButton(
            onPressed: (){
              print("onButtonClick: 已完成");
              _showType = ShowType.done;
              setState(() {

              });
            },
            child: const Text("已完成")),
        ElevatedButton(
            onPressed: (){
              print("onButtonClick: 未完成");
              _showType = ShowType.todo;
              setState(() {

              });
            },
            child: const Text("未完成")),
      ],
    );

    var list = _createListByType(_showType, _todo);


    return Column(
      children: [
        inputRow,
        buttonRow,
        Expanded(child: list)
      ],
    );
  }

  _creatTextField() {
    return TextField(
      controller: TextEditingController(),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      maxLines: 1,
      cursorColor: Colors.black,
      cursorWidth: 3,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.lightBlue,
        backgroundColor: Colors.white
      ),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: '添加一个待办事项',
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 14
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
      ),
      onChanged: (str) {
        print("textField input onChanged = $str");
        _text = str;
      },
    );
  }

  _creatAddBtn() {
    return ElevatedButton(
      child: const Icon(Icons.add),
      onPressed: () {
        print("onAddBtnClick");
        //收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
        if(_text != null && _text != "") {
          _todo[_text] = false;
          _text = "";
          setState(() {

          });

        }
      },
    );
  }

  _createListByType(ShowType showType, Map<String, bool> todo) {
    switch (showType) {
      case ShowType.all:
        return _createList(todo);
      case ShowType.todo:
        return _createList(Map.fromEntries(todo.entries.where((element) => element.value == false)));
      case ShowType.done:
        return _createList(Map.fromEntries(todo.entries.where((element) => element.value == true)));
    }
  }
  
  _createList(Map<String, bool> todo) {
    return ListView.builder(
      itemCount: todo.length,
        padding: const EdgeInsets.all(8),
        itemExtent: 50.0,
        itemBuilder: (context, index) {
          var key = todo.keys.elementAt(index);
          var value = todo.values.elementAt(index);
          var text = Align(
            alignment: Alignment.centerLeft,
            child: Text(
              key,
              style: TextStyle(
                decorationThickness: 3,
                decoration: value ? TextDecoration.lineThrough : TextDecoration.none,
                decorationColor: Colors.blueAccent,
              ),
            ),
          );

          return Card(
            child: Row(
              children: [
                Checkbox(value: value, onChanged: (b){
                    print("onItemCheckboxChanged: $b, key = $key");
                    _todo[key] = b??false;
                    setState(() {

                    });
                }),
                text
              ],
            ),
          );
        }
    );
  }
}
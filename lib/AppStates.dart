
import 'package:fluttermodule/beans/User.dart';

import 'models/Models.dart';
///定义Redux的AppState，用于存储Redux中的数据，全局共享，
///其中包含用户信息，和数据模型列表
class AppState {

  final User user; //用户信息
  final List<DataModel> data; //通用数据模型列表

  AppState({required this.user, required this.data});
}

///增加计数器State
class IncrementCounterState extends AppState {
  final int counter;
  IncrementCounterState({required super.user, required super.data, required this.counter});
}

///更新用户信息State
class UpdateUserState extends AppState {
  UpdateUserState({required super.user, required super.data});
}

///增加数据State
class AddDataState extends AppState {
  AddDataState({required super.user, required super.data});
}
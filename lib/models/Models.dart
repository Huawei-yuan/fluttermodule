///定义通用数据模型, 用于Redux AppState中数据模型的定义]
///该模型包含所有数据类型都共享的属性和方法
abstract class DataModel {
  final String id;
  final int createdTime = DateTime.now().millisecondsSinceEpoch;
  DataModel({required this.id});
}

///公告类 继承自 DataModel
class Post extends DataModel {
  String title;//标题
  String content;//内容
  Post({required super.id, required this.title, required this.content});
}

///产品类 继承自 DataModel
class Product extends DataModel {
  String name;
  double price;
  Product({required super.id, required this.name, required this.price});
}
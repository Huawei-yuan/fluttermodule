///用户信息
class User {
  final String id;
  final String name;
  final int gender;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.gender,
    this.age = 10
  });
}
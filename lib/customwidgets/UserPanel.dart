import 'package:flutter/material.dart';

class UserInfo {
  String name; //名字
  int level; //等级
  String image; //头像
  String post; //职务
  String company; //公司
  String proverbs; //箴言

  UserInfo({
    required this.name,
    required this.level,
    required this.image,
    required this.post,
    required this.company,
    required this.proverbs,
  });
}

///仿掘金个人信息卡片
class UserPanel extends StatelessWidget {

  final titleTextStyle = const TextStyle(color: Colors.black, fontSize: 20);
  final infoTextStyle = const TextStyle(color: Color(0xff72777B), fontSize: 14);

  final UserInfo userInfo;

  final VoidCallback editCallback;

  const UserPanel({super.key, required this.userInfo, required this.editCallback});

  @override
  Widget build(BuildContext context) {
    var left = ClipOval(
      child: Image.network(userInfo.image,
        fit: BoxFit.cover,
        width: 50,
        height: 50,),
    );

    var userNameRow = Row(
      children: [
        Text(userInfo.name, style: titleTextStyle),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xff34D19B),
            child: Text(
              userInfo.level.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 10
              ),
            ),
          ),
        )
      ],
    );

    var infoRow = Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(Icons.next_week, size: 15,),
        ),
        Text(
          userInfo.post,
          style: infoTextStyle,
        )
      ],
    );

    var say = Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(Icons.keyboard, size: 15,),
        ),
        Expanded(
            child: Text(userInfo.proverbs, style: infoTextStyle,))
      ],
    );

    var center = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userNameRow,
        infoRow,
        say
      ],
    );

    var right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [
            Icon(
              Icons.language,
              size: 18,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.local_pharmacy, size: 18,),),
            Icon(Icons.person_pin_circle, size: 18,)
          ],
        ),
        OutlinedButton(
            onPressed: editCallback,
            child: const Text("编辑资料", style: TextStyle(),),
        )
      ],
    );

    return Card(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: left,
          ),
          Expanded(child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: center,
          )),
          Container(
            margin: const EdgeInsets.all(10),
            child: right,
          )
        ],
      ),
    );
  }
}
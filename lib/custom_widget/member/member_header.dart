import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberHeaderPage extends StatelessWidget {
  const MemberHeaderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'http://b-ssl.duitang.com/uploads/item/201711/10/20171110225150_ym2jw.jpeg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '信用飞',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

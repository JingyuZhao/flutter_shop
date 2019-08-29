import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodDetailExplain extends StatelessWidget {
  const GoodDetailExplain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Text(
          '说明：> 急速送达 > 正品保证',
          style:
              TextStyle(color: Colors.brown, fontSize: ScreenUtil().setSp(30)),
        ));
  }
}

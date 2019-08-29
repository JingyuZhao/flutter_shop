import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';

class GoodsDetailTabbar extends StatelessWidget {
  const GoodsDetailTabbar({Key key}) : super(key: key);

  Widget _myTabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context).changeTabBarState(true);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text(
          '详细',
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context).changeTabBarState(false);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: isRight ? Colors.pink : Colors.black12))),
        child: Text(
          '评论',
          style: TextStyle(color: isRight ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, tabbarInfo) {
        var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        var isRight = Provide.value<GoodsDetailInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabbarLeft(context, isLeft),
                  _myTabBarRight(context, isRight)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

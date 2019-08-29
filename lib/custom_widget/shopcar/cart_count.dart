import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/model_cart_item.dart';
import 'package:flutter_shop/provide/shopcar/provide_shopcar.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final CartGoodsModel item;
  const CartCount({Key key, this.item}) : super(key: key);

//减少按钮
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, false);
      },
      child: Container(
        width: ScreenUtil().setWidth(40),
        height: ScreenUtil().setHeight(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text(item.count > 1 ? '-' : ''),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, true);
      },
      child: Container(
        width: ScreenUtil().setWidth(40),
        height: ScreenUtil().setHeight(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(30),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(155),
      margin: EdgeInsets.only(top: 10.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }
}

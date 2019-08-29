import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/index/provide_currentIndex.dart';

import 'package:flutter_shop/provide/shopcar/provide_shopcar.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';

import 'package:provide/provide.dart';

class GoodDetailBottom extends StatelessWidget {
  const GoodDetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Provide.value<CurrtentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.pink,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, cartInfo) {
                  int goodsNumber = cartInfo.allGoodsCount;

                  return Positioned(
                    top: 2,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 2, color: Colors.pink)),
                      child: Text(
                        '$goodsNumber',
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              var goodInfo = Provide.value<GoodsDetailInfoProvide>(context)
                  .goodsInfo
                  .data
                  .goodInfo;
              Provide.value<CartProvide>(context).save(
                  goodInfo.goodsId,
                  goodInfo.goodsName,
                  1,
                  goodInfo.presentPrice,
                  goodInfo.image1);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(100),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(100),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

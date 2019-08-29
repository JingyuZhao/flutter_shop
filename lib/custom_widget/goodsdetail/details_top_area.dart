import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//详情页面，顶部详情
class GoodsDetailTopArea extends StatelessWidget {
  const GoodsDetailTopArea({Key key}) : super(key: key);

//大图
  Widget _getGoodImage(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
      fit: BoxFit.fill,
    );
  }

//商品名称
  Widget _getGoodName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  //商品编号
  Widget _getGoodNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：$num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  //商品价格信息
  Widget _getGoodPrice(nowPrice, orilPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '¥$nowPrice',
              style: TextStyle(
                  color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(40)),
            ),
          ),
          Container(
            child: Text(
              '市场价：¥$orilPrice',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, data) {
        var goodsInfo = Provide.value<GoodsDetailInfoProvide>(context)
            .goodsInfo
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                _getGoodImage(goodsInfo.image1),
                _getGoodName(goodsInfo.goodsName),
                _getGoodNum(goodsInfo.goodsSerialNumber),
                _getGoodPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {}
      },
    );
  }
}

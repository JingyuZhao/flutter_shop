import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';

import 'package:flutter_shop/custom_widget/goodsdetail/details_top_area.dart';
import 'package:flutter_shop/custom_widget/goodsdetail/details_explain.dart';
import 'package:flutter_shop/custom_widget/goodsdetail/detail_tabbar.dart';
import 'package:flutter_shop/custom_widget/goodsdetail/detail_web.dart';
import 'package:flutter_shop/custom_widget/goodsdetail/detail_bottom.dart';

class GoodDetailPage extends StatelessWidget {
  final String goodsId;
  const GoodDetailPage({Key key, this.goodsId}) : super(key: key);

  Future _getGoodsDerailInfo(BuildContext context) async {
    await Provide.value<GoodsDetailInfoProvide>(context)
        .getGoodsDetail(this.goodsId);
    return '加载完成';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getGoodsDerailInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                    child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    GoodsDetailTopArea(),
                    GoodDetailExplain(),
                    GoodsDetailTabbar(),
                    GoodDetailWebView()
                  ],
                )),
                Positioned(
                    left: 0, right: 0, bottom: 0, child: GoodDetailBottom())
              ],
            );
          } else {
            return Text('加载中........');
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';
import 'package:flutter_shop/model/model_goods_detail.dart';

class GoodDetailWebView extends StatelessWidget {
  const GoodDetailWebView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<GoodsDetailInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    List<GoodComments> comments = Provide.value<GoodsDetailInfoProvide>(context)
        .goodsInfo
        .data
        .goodComments;
    Widget _getComments(index) {
      return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black26))),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              child: Text('${comments[index].userName}',
                  textAlign: TextAlign.left),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
              child: Text(
                '${comments[index].comments}',
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      );
    }

    Widget _getAbversiterImage() {
      var adversity = Provide.value<GoodsDetailInfoProvide>(context)
          .goodsInfo
          .data
          .advertesPicture;
      return Image.network(adversity.pICTUREADDRESS);
    }

    List<Widget> _getCommentsItem() {
      List<Widget> list = [];
      comments.forEach((GoodComments item) {
        list.add(_getComments(comments.indexOf(item)));
      });
      list.add(_getAbversiterImage());
      return list;
    }

    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetail,
            ),
          );
        } else {
          if (comments != null || comments.length > 0) {
            return Container(
              width: ScreenUtil().setWidth(750),
              child: Column(
                children: _getCommentsItem(),
              ),
            );
          } else {
            print('object');
            return Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text('暂时没有数据'));
          }
        }
      },
    );
  }
}

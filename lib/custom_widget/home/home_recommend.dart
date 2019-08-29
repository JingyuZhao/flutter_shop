import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/application.dart';

class Recommend extends StatelessWidget {
  final List recommend;
  const Recommend({Key key, this.recommend}) : super(key: key);

//推荐的标题
  Widget _titleWidget() {
    return Container(
      child: Text(
        '商品推荐',
        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.pink),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: ScreenUtil().setHeight(60),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
    );
  }

  //推荐的item项
  Widget _recommendItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "/detail?id=${recommend[index]['goodsId']}",
            transition: TransitionType.cupertino);
      },
      child: Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(160),
              child: Image.network(recommend[index]['image']),
            ),
            Text('￥${recommend[index]['mallPrice']}'),
            Text(
              '￥${recommend[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  //推荐页，横向列表页面
  Widget _recommendListView() {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommend.length,
        itemBuilder: (context, index) {
          return _recommendItem(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(360),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendListView()],
      ),
    );
  }
}

import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/config/service_url.dart';

import 'package:flutter_shop/custom_widget/category/category_page_leftList.dart';
import 'package:flutter_shop/custom_widget/category/category_page_right.dart';

import 'package:flutter_shop/model/model_category_item.dart';
import 'package:flutter_shop/provide/category/provide_category_child.dart';
import 'package:flutter_shop/provide/category/provide_category_smalllist.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          CategoryLeftNav(),
          Column(
            children: <Widget>[RightCategoryNav(), CategoryGoodsList()],
          )
        ],
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollerController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _getGoodsList({'page': '1', 'categorySubId': '', 'categoryId': '4'});
    super.initState();
  }

  void _getGoodsList(Map paramter) async {
    await postRequest(category_page_small_category, paramter: paramter)
        .then((val) {
      var data = json.decode(val.toString());
      CategorySmallItemModel goodList = CategorySmallItemModel.fromJson(data);
      Provide.value<ChildCategorySmallListProvide>(context)
          .getGoodsList(goodList.data);
    });
  }

  void _loadMoreList() async {
    var paramter = {
      'categoryId':
          Provide.value<ChildCategoryProvide>(context).childCategoryId,
      'categorySubId':
          Provide.value<ChildCategoryProvide>(context).subCategoryId,
      'page': Provide.value<ChildCategoryProvide>(context).page
    };
    print('loadMore:$paramter');
    await postRequest(category_page_small_category, paramter: paramter)
        .then((val) {
      var data = json.decode(val.toString());
      CategorySmallItemModel goodList = CategorySmallItemModel.fromJson(data);
      if (goodList.data == null || goodList.data.length == 0) {
        Provide.value<ChildCategoryProvide>(context).changeNoMoreText('没有更多了');
        Fluttertoast.showToast(msg: '没有更多商品了', gravity: ToastGravity.CENTER);
      } else {
        Provide.value<ChildCategorySmallListProvide>(context)
            .addGoodsList(goodList.data);
        Provide.value<ChildCategoryProvide>(context).addPage();
      }
    });
  }

  Widget _goodsImage(List<CategorySmallItemDetailModel> smallItemList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(smallItemList[index].image),
    );
  }

  Widget _getGoodsName(
      List<CategorySmallItemDetailModel> smallItemList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.only(left: 10),
      child: Text(
        smallItemList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _getGoodsPrice(
      List<CategorySmallItemDetailModel> smallItemList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 10),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 0),
            child: Text(
              '价格:￥${smallItemList[index].presentPrice}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          Container(
            child: Text('￥${smallItemList[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough)),
          ),
        ],
      ),
    );
  }

  Widget _smallItemDetail(
      List<CategorySmallItemDetailModel> smallItemList, int index) {
    return InkWell(
        onTap: () {
          Application.router.navigateTo(
              context, "/detail?id=${smallItemList[index].goodsId}",
              transition: TransitionType.cupertino);
        },
        child: Container(
          width: ScreenUtil().setWidth(370),
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Row(
            children: <Widget>[
              _goodsImage(smallItemList, index),
              Column(
                children: <Widget>[
                  _getGoodsName(smallItemList, index),
                  _getGoodsPrice(smallItemList, index)
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategorySmallListProvide>(
      builder: (context, child, data) {
        //空数据展示
        if (data.goodList == null || data.goodList.length == 0) {
          return Expanded(
            child: Center(
              child: Text('无数据'),
            ),
          );
        } else {
          //点击的时候，回到顶部
          try {
            if (Provide.value<ChildCategoryProvide>(context).page == 1) {
              scrollerController.jumpTo(0.0);
            }
          } catch (e) {
            print('进入页面第一次初始化：${e}');
          }
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                onLoad: () async {
                  _loadMoreList();
                },
                footer: ClassicalFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    noMoreText:
                        Provide.value<ChildCategoryProvide>(context).noMoreText,
                    loadReadyText: '上拉加载'),
                child: ListView.builder(
                  controller: scrollerController,
                  scrollDirection: Axis.vertical,
                  itemCount: data.goodList.length,
                  itemBuilder: (context, index) {
                    return _smallItemDetail(data.goodList, index);
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

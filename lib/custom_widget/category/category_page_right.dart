import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/config/service_url.dart';

import 'package:flutter_shop/model/model_category.dart';
import 'package:flutter_shop/model/model_category_item.dart';

import 'package:flutter_shop/provide/category/provide_category_child.dart';
import 'package:flutter_shop/provide/category/provide_category_smalllist.dart';

import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  Widget _rightItem(CategorySmallModel item, int index, String bigCategoryId) {
    bool isCheck = false;
    isCheck = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;

    return InkWell(
        onTap: () {
          Provide.value<ChildCategoryProvide>(context)
              .changeChildCategory(item.mallSubId, index);
          var data = {
            'categoryId':
                Provide.value<ChildCategoryProvide>(context).childCategoryId,
            'page': '1',
            'categorySubId': item.mallSubId == null ? '' : item.mallSubId
          };
          print('request:$data');
          _getGoodsList(data);
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              item.mallSubName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: isCheck ? Colors.pink : Colors.black),
            ),
          ),
        ));
  }

  void _getGoodsList(Map paramter) async {
    await postRequest(category_page_small_category, paramter: paramter)
        .then((val) {
      var data = json.decode(val.toString());
      print('object:$data');
      CategorySmallItemModel goodList = CategorySmallItemModel.fromJson(data);
      Provide.value<ChildCategorySmallListProvide>(context)
          .getGoodsList(goodList.data);
      Provide.value<ChildCategoryProvide>(context).addPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (context, child, categoryInfo) {
        return Container(
          child: Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryInfo.childCategory.length,
              itemBuilder: (context, index) {
                return _rightItem(categoryInfo.childCategory[index], index,
                    categoryInfo.childCategoryId);
              },
            ),
          ),
        );
      },
    );
  }
}

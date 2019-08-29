import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/model_category.dart';
import 'package:flutter_shop/model/model_category_item.dart';

import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/category/provide_category_child.dart';
import 'package:flutter_shop/provide/category/provide_category_smalllist.dart';

class CategoryLeftNav extends StatefulWidget {
  CategoryLeftNav({Key key}) : super(key: key);

  _CategoryLeftNavState createState() => _CategoryLeftNavState();
}

class _CategoryLeftNavState extends State<CategoryLeftNav> {
  List<CategoryBigModel> list = [];
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _getCategory();
    super.initState();
  }

  void _getCategory() {
    postRequest(category_page_content).then((categoryData) {
      var categoryInfo = json.decode(categoryData.toString());
      CategoryListModel categoryListInfo =
          CategoryListModel.formJson((categoryInfo['data'] as List));
      setState(() {
        list = categoryListInfo.data;
      });
      //请求成功之后，把第一个分类的数据传送过去
      Provide.value<ChildCategoryProvide>(context)
          .getChildCategoryInfo(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

//大类的item
  Widget _leftListItem(int index) {
    CategoryBigModel model = list[index];
    return InkWell(
      onTap: () {
        print('${model.mallCategoryName}');
        var childList = model.bxMallSubDto;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategoryInfo(childList, model.mallCategoryId);
        var data = {
          'categoryId':
              model.mallCategoryId == null ? '4' : model.mallCategoryId,
          'page': '1',
          'categorySubId': ''
        };
        _getGoodsList(data);
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: selectedIndex != index
                ? Colors.white
                : Color.fromRGBO(236, 236, 236, 1),
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          model.mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftListItem(index);
        },
      ),
    );
  }
}

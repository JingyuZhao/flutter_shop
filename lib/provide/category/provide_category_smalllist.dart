import 'package:flutter/material.dart';
import 'package:flutter_shop/model/model_category_item.dart';

class ChildCategorySmallListProvide with ChangeNotifier {
  List<CategorySmallItemDetailModel> goodList = [];
  String bigCategory = '';
  getGoodsList(List<CategorySmallItemDetailModel> list) {
    goodList = list;
    notifyListeners();
  }

  //上拉加载增加数据
  addGoodsList(List<CategorySmallItemDetailModel> addList) {
    goodList.addAll(addList);
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_shop/model/model_category.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<CategorySmallModel> childCategory = [];

  int childIndex = 0; //小类的当前选中项

  String childCategoryId = '4'; //大类id

  String subCategoryId = ''; //小类id

  int page = 1; //上拉加载页数
  String noMoreText = ''; //没有数据的时候展示

  //切换大类
  getChildCategoryInfo(List<CategorySmallModel> list, String bigCategoryInfo) {
    //切换的大类的时候，要设置为初始状态
    page = 1;
    noMoreText = '';
    childIndex = 0;

    childCategoryId = bigCategoryInfo;
    CategorySmallModel all = CategorySmallModel();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategory = [all];
    childCategory.addAll(list);
    notifyListeners();
  }

  changeChildCategory(String subId, int selectedIndex) {
    //切换的小类的时候，要设置为初始状态
    page = 1;
    noMoreText = '';

    childIndex = selectedIndex;
    subCategoryId = subId;
    notifyListeners();
  }

//增加页数
  addPage() {
    page++;
  }

  //改变noMoreText文字
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}

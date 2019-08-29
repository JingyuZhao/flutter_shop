import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/model_goods_detail.dart';

/**
 * 在实际开发中，我们是将业务逻辑和UI表现分开的，所以线建立一个Provide文件，
 * 所有业务逻辑将写在Provide里，然后pages文件夹里只写UI层面的东西。
 * 这样就把业务逻辑和UI进行了分离。
 */
class GoodsDetailInfoProvide with ChangeNotifier {
  //商品详情信息
  GoodsDetailModel goodsInfo = null;

  getGoodsDetail(String goodId) async {
    //每次进详情的时候要重新设置
    isLeft = true;
    isRight = false;

    await postRequest(goods_goods_detail, paramter: {'goodId': goodId})
        .then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = GoodsDetailModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //自定义tabbar
  bool isLeft = true;
  bool isRight = false;

//改变tabbar的状态
  changeTabBarState(bool choiceLeft) {
    isLeft = choiceLeft;
    isRight = !choiceLeft;
    notifyListeners();
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';

import 'package:provide/provide.dart';

import 'package:flutter_shop/provide/category/provide_category_child.dart';
import 'package:flutter_shop/provide/category/provide_category_smalllist.dart';
import 'package:flutter_shop/provide/goodsdetail/provide_goods_detail.dart';
import 'package:flutter_shop/provide/shopcar/provide_shopcar.dart';
import 'package:flutter_shop/provide/index/provide_currentIndex.dart';

import 'package:flutter_shop/router/application.dart';
import 'package:flutter_shop/router/routes.dart';

void main() {
  var childCategory = ChildCategoryProvide();
  var childCategorySmallItemList = ChildCategorySmallListProvide();
  var goodsDetailInfo = GoodsDetailInfoProvide();
  var shopCar = CartProvide();
  var current = CurrtentIndexProvide();

  var providers = Providers();

  providers
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider<ChildCategorySmallListProvide>.value(
        childCategorySmallItemList))
    ..provide(Provider<GoodsDetailInfoProvide>.value(goodsDetailInfo))
    ..provide(Provider<CurrtentIndexProvide>.value(current))
    ..provide(Provider<CartProvide>.value(shopCar));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //注册路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      //配置路由。注入整个程序，让我们在任何页面直接引入application.dart
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}

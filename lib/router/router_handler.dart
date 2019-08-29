import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/good_details_page.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramter) {
  print('router:$paramter');
  String goodId = paramter['id'].first;
  return GoodDetailPage(
    goodsId: goodId,
  );
});

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/model_cart_item.dart';
import 'package:flutter_shop/provide/shopcar/provide_shopcar.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_shop/custom_widget/shopcar/cart_item.dart';
import 'package:flutter_shop/custom_widget/shopcar/cart_bottom.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget _getEmptyWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(80),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '购物车没有商品哦，赶快去选购',
              maxLines: 2,
            ),
          ),
          RaisedButton(
            child: Container(
              width: ScreenUtil().setWidth(180),
              height: ScreenUtil().setHeight(60),
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text('去选购')
                ],
              ),
            ),
            onPressed: () {},
            textColor: Colors.white,
            highlightColor: Colors.green,
            color: Colors.green,
          )
        ],
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CartGoodsModel> carInfo =
                  Provide.value<CartProvide>(context).cartList;
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, shopcar) {
                      carInfo = Provide.value<CartProvide>(context).cartList;
                      return ListView.builder(
                        itemCount: carInfo.length,
                        itemBuilder: (context, index) {
                          return CartItem(item: carInfo[index]);
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return _getEmptyWidget();
            }
          },
        ));
  }
}

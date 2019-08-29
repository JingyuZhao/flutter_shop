import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/application.dart';

class SectionContent extends StatelessWidget {
  final List floorGoodList;
  const SectionContent({Key key, this.floorGoodList}) : super(key: key);

  Widget _firstRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodList[1]),
            _goodsItem(context, floorGoodList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodList[3]),
        _goodsItem(context, floorGoodList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map good) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('${good['image']}');
          Application.router.navigateTo(
              context, "/detail?id=${good['goodsId']}",
              transition: TransitionType.cupertino);
        },
        child: Image.network(
          good['image'],
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherRow(context)],
      ),
    );
  }
}

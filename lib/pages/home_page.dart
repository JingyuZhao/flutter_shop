import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/custom_widget/home/home_menu_item.dart';
import 'package:flutter_shop/custom_widget/home/home_ad_banner.dart';
import 'package:flutter_shop/custom_widget/home/home_call_phone.dart';
import 'package:flutter_shop/custom_widget/home/home_recommend.dart';
import 'package:flutter_shop/custom_widget/home/home_section_header.dart';
import 'package:flutter_shop/custom_widget/home/home_section_content.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_shop/router/application.dart';

/**
总结：
flutter_Swiper:学习了flutter_swiper组件的简单使用方法，当然你还可以自己学习。
FutureBuilder: 这个布局可以很好的解决异步渲染的问,实战中我们讲了很多使用的技巧，注意反复学习。
自定义类接受参数：我们复习了类接受参数的方法。学会了这个技巧就可以把我们的页面分成很多份，让很多人来进行编写，最后再整合到一起。

easy_refresh要求下拉和上拉的组件必须是ListView
 *  */
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  //上拉加载更多page
  int belowContetPage = 1;
  //上拉加载更多的内容
  List<Map> belowContentList = [];

  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    _getBelowGoods();
    super.initState();
  }

  //上拉加载更多
  void _getBelowGoods() {
    postRequest(home_page_below_conten, paramter: {'page': belowContetPage})
        .then((responeData) {
      var data = json.decode(responeData.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        belowContentList.addAll(newGoodsList);
        belowContetPage++;
      });
    });
  }

  //火爆专区title
  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("火爆专区"),
  );
  //火爆专区listView，GridView组件的性能时很低的，毕竟网格的绘制不难么简单，所以这里使用了Warp来进行布局。Warp是一种流式布局。
  Widget _wrapList() {
    if (belowContentList.length != 0) {
      List<Widget> listwidget = belowContentList.map((itemInfo) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(
                context, "/detail?id=${itemInfo['goodsId']}",
                transition: TransitionType.inFromRight);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  itemInfo['image'],
                  width: ScreenUtil().setWidth(375),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    itemInfo['name'],
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text('￥${itemInfo['mallPrice']}'),
                        margin: EdgeInsets.only(left: 10),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          '￥${itemInfo['price']}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black26,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listwidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotContent() {
    return Column(
      children: <Widget>[_hotTitle, _wrapList()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          //这是一个Flutter内置的组件，是用来等待异步请求的
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast(); //类别列表
              String advertesPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
              String leaderImage =
                  data['data']['shopInfo']['leaderImage']; //店长图片
              String leaderPhone =
                  data['data']['shopInfo']['leaderPhone']; //店长电话
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); //类别列表
              String section_one_picture =
                  data['data']['floor1Pic']['PICTURE_ADDRESS'];
              List<Map> section_one_list =
                  (data['data']['floor1'] as List).cast(); //floor1
              String section_two_picture =
                  data['data']['floor1Pic']['PICTURE_ADDRESS'];
              List<Map> section_two_list =
                  (data['data']['floor2'] as List).cast(); //floor2
              String section_three_picture =
                  data['data']['floor1Pic']['PICTURE_ADDRESS'];
              List<Map> section_three_list =
                  (data['data']['floor3'] as List).cast(); //floor3

              return EasyRefresh(
                footer: ClassicalFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    loadText: '上拉加载'),
                onLoad: () async {
                  print('开始加载更多');
                  _getBelowGoods();
                },
                onRefresh: () async {
                  getHomePageContent().then((val) {
                    setState(() {
                      homePageContent = val.toString();
                      belowContetPage = 1;
                      belowContentList.clear();
                    });
                  });
                },
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    ADBanner(advertesPicture: advertesPicture), //广告
                    LeaderPhone(
                        leaderImage: leaderImage,
                        leaderPhone: leaderPhone), //广告组件
                    Recommend(
                      recommend: recommendList,
                    ),
                    SectionHeader(
                      picture_address: section_one_picture,
                    ),
                    SectionContent(
                      floorGoodList: section_one_list,
                    ),
                    SectionHeader(
                      picture_address: section_two_picture,
                    ),
                    SectionContent(
                      floorGoodList: section_two_list,
                    ),
                    SectionHeader(
                      picture_address: section_three_picture,
                    ),
                    SectionContent(
                      floorGoodList: section_three_list,
                    ),
                    _hotContent()
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }

/** 
 * AutomaticKeepAliveClientMixin这个Mixin就是Flutter为了保持页面设置的。哪个页面需要保持页面状���，就在这个页面进行混入。

不过使用使用这个Mixin是有几个先决条件的：

使用的页面必须是StatefulWidget,如果是StatelessWidget是没办法办法使用���。
其实只有两个前置组件才能保持页面状态：PageView和IndexedStack。
重写wantKeepAlive方法，如果不重写也是实现不了的。
*/
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//轮播图
class SwiperDiy extends StatelessWidget {
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  final List swiperDataList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        onTap: (index) {},
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}

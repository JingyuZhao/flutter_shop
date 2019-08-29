import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/member_page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/index/provide_currentIndex.dart';
import 'package:provide/provide.dart';

//新的方式
class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心"))
  ];

  final List<Widget> pagesArr = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    //初始化
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrtentIndexProvide>(
      builder: (context, child, indexInfo) {
        int currentIndex =
            Provide.value<CurrtentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType
                .fixed, //type:BottomNavigationBarType.fixed,这个是设置底部tab的样式，它有两种样式fixed和shifting，只有超过3个才会有区别
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrtentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: pagesArr,
          ),
        );
      },
    );
  }
}
//老的方式
// class IndexPage extends StatefulWidget {
//   IndexPage({Key key}) : super(key: key);

//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.search), title: Text("分类")),
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心"))
//   ];

//   final List<Widget> pagesArr = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage()
//   ];

//   int currentIndex = 0;
//   var currentPage;

//   @override
//   void initState() {
//     currentIndex = 0;
//     currentPage = pagesArr[currentIndex];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //初始化
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType
//             .fixed, //type:BottomNavigationBarType.fixed,这个是设置底部tab的样式，它有两种样式fixed和shifting，只有超过3个才会有区别
//         currentIndex: currentIndex,
//         items: bottomTabs,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//             currentPage = pagesArr[currentIndex];
//           });
//         },
//       ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: pagesArr,
//       ),
//     );
//   }
// }

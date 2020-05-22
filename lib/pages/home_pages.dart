import 'package:flutter/material.dart';
import 'package:flutterxiecheng/dao/home_dao.dart';
import 'package:flutterxiecheng/model/gridnav_model.dart';
import 'package:flutterxiecheng/model/home_model.dart';
import 'package:flutterxiecheng/model/scalebox_model.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  List<CommonModel> bannerList = []; //轮播图列表
  List<CommonModel> localNavList = []; //local导航
  GridNavModel gridNav; //网格卡片
  List<CommonModel> subNavList = []; //活动导航
  ScaleBoxModel salesBox; //salesBox数据
  bool _loading = true; //页面加载状态
  String city = '西安市';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home页"),
    );
  }




  //加载首页数据
  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNav = model.gridview;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }
}

import 'dart:convert';

import 'package:flutterxiecheng/model/config_model.dart';
import 'package:flutterxiecheng/model/gridnav_model.dart';
import 'package:flutterxiecheng/model/scalebox_model.dart';

class HomeModel{
 ConfigModel config;
 GridNavModel gridNav;
 ScaleBoxModel salesBox;
 List<CommonModel> bannerList;
 List<CommonModel> localNavList;
 List<CommonModel> subNavList;

 HomeModel({this.config, this.gridNav, this.salesBox, this.bannerList,
     this.localNavList, this.subNavList});

 factory HomeModel.fromjson(Map<String,dynamic> json){
   var localNavListJson = json['localNavList'] as List;
   List<CommonModel> localNavList =
   localNavListJson.map((i) => CommonModel.fromjson(i)).toList();

   var bannerListJson = json['bannerList'] as List;
   List<CommonModel> bannerList =
   bannerListJson.map((i) => CommonModel.fromjson(i)).toList();

   var subNavListJson = json['subNavList'] as List;
   List<CommonModel> subNavList =
   subNavListJson.map((i) => CommonModel.fromjson(i)).toList();

   return HomeModel(
   config: ConfigModel.fromjson(json["config"]),
     gridNav: GridNavModel.fromjson(json["gridNav"]),
     salesBox: ScaleBoxModel.fromJson(json["salesBox"]),
     localNavList: localNavList,
     bannerList: bannerList,
     subNavList: subNavList,



   );
 }


}


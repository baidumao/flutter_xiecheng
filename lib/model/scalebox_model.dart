import 'dart:convert';

import 'package:flutterxiecheng/model/gridnav_model.dart';

class ScaleBoxModel{
  String icon;
  String moreUrl;
  CommonModel bigCard1;
  CommonModel bigCard2;
   CommonModel smallCard1;
   CommonModel smallCard2;
   CommonModel smallCard3;
   CommonModel smallCard4;

  ScaleBoxModel({this.icon, this.moreUrl, this.bigCard1, this.bigCard2,
      this.smallCard1, this.smallCard2, this.smallCard3, this.smallCard4});
  factory ScaleBoxModel.fromJson(Map<String, dynamic> json) {
    return ScaleBoxModel(
      icon:json["icon"],
      moreUrl:json["moreUrl"],
      bigCard1:CommonModel.fromjson(json["bigCard1"]),
      bigCard2:CommonModel.fromjson(json["bigCard2"]),
      smallCard1:CommonModel.fromjson(json["smallCard1"]),
      smallCard2:CommonModel.fromjson(json["smallCard2"]),
      smallCard3:CommonModel.fromjson(json["smallCard3"]),
      smallCard4:CommonModel.fromjson(json["smallCard4"]),
    );
  }

  Map<String,dynamic> tojson(){
    Map<String,dynamic> map=Map();
    map["icon"]=this.icon;
    map["moreUrl"]=this.moreUrl;
    map["bigCard1"]=this.bigCard1.tojson();
    map["bigCard2"]=this.bigCard1.tojson();
    map["smallCard1"]=this.bigCard1.tojson();
    map["smallCard2"]=this.bigCard2.tojson();
    map["smallCard3"]=this.smallCard3.tojson();
    map["smallCard4"]=this.smallCard4.tojson();
    return map;
  }


}




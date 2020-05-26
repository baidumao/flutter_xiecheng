class GridNavModel{
  GridNavItem flight;
  GridNavItem hotel;
  GridNavItem travel;

  GridNavModel({this.flight, this.hotel, this.travel});

  factory GridNavModel.fromjson(Map<String,dynamic> json){
    return GridNavModel(flight: GridNavItem.fromjson(json["flight"]),hotel: GridNavItem.fromjson(json["hotel"]),travel: GridNavItem.fromjson(json["travel"]));
  }

}

class GridNavItem {
  String startColor;
  String endColor;
  CommonModel item1;
  CommonModel item2;
  CommonModel item3;
  CommonModel item4;
  CommonModel mainItem;

  GridNavItem({this.startColor, this.endColor, this.item1, this.item2,
      this.item3, this.item4, this.mainItem});

  factory GridNavItem.fromjson(Map<String,dynamic> json){
  return GridNavItem(startColor:json["startColor"],endColor:json["endColor"],item1: CommonModel.fromjson(json["item1"]),item2: CommonModel.fromjson(json["item2"]),item3: CommonModel.fromjson(json["item3"]),item4: CommonModel.fromjson(json["item4"]),mainItem: CommonModel.fromjson(json["mainItem"]));
  }

  Map<String,dynamic> tojson(){
    Map<String,dynamic> map=Map();
    map["startColor"]=this.startColor;
    map["endColor"]=this.endColor;
    map["item1"]=this.item1.tojson();
    map["item2"]=this.item2.tojson();
    map["item3"]=this.item3.tojson();
    map["item4"]=this.item4.tojson();
    map["mainItem"]=this.mainItem.tojson();

  }

}

class CommonModel {

  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromjson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }

  Map<String,dynamic> tojson(){
    Map<String,dynamic> map=Map();
    map["hideAppBar"]=this.hideAppBar;
    map["title"]=this.title;
    map["url"]=this.url;
    map["icon"]=this.icon;
    map["statusBarColor"]=this.statusBarColor;
    return map;

  }


}
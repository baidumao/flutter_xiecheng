//旅拍类别模型

class TravelTabModel{
  String url;
  Map params;
  List<TravelTab> tabs;

  TravelTabModel({this.url, this.params, this.tabs});
  factory TravelTabModel.fromjson(Map<String,dynamic> json){

    var tabs = json['tabs'] as List;
    List <TravelTab> tansjson=tabs.map((i)=>TravelTab.fromjson(i)).toList();
    return TravelTabModel(url:json["url"],
     params: json["params"],
      tabs:tansjson
    );
  }

}

class TravelTab {
  String groupChannelCode;
  String labelName;
  int type;

  TravelTab({this.groupChannelCode, this.labelName, this.type});

  factory TravelTab.fromjson(Map<String, dynamic> json){
    return TravelTab(groupChannelCode: json["groupChannelCode"],
    labelName: json["labelName"],
      type: json["type"]
    );
  }

  Map<String,dynamic> tojson(){
    Map<String,dynamic> map=Map();
    map["groupChannelCode"]=this.groupChannelCode;
    map["labelName"]=this.labelName;
    map["type"]=this.type;
    return map;

  }



}
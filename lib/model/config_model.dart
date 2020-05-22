class ConfigModel {
  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromjson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json["searchUrl"]);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = Map();
    map[searchUrl] = this.searchUrl;
    return map;
  }
}

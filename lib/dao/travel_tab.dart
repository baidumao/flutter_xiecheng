import 'package:dio/dio.dart';
import 'package:flutterxiecheng/model/travel_tab_model.dart';

const TRAVEL_TAB_URL =
    'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/travel_page.json';

//旅拍类别接口
class TravelTabDao{
   static Future<TravelTabModel> fetch() async{
     var response = await Dio().get(TRAVEL_TAB_URL);
     if(response.statusCode==200){
       return TravelTabModel.fromjson(response.data);
     }else {
       throw Exception('Failed to load home_page.json');
     }
   }
}



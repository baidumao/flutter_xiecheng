import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutterxiecheng/model/home_model.dart';
const HOME_URL =
    'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/home_page.json';

class HomeDao{
 static Future<HomeModel>fetch() async{
var response = await Dio().get(HOME_URL);
    if(response.statusCode==200){
     return HomeModel.fromjson(response.data);
    }else {
      throw Exception('Failed to load home_page.json');
    }

 }
}
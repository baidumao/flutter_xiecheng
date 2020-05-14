import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';


class Tab_Navigator extends StatefulWidget {
  @override
  _Tab_NavigatorState createState() => _Tab_NavigatorState();
}



class _Tab_NavigatorState extends State<Tab_Navigator> {
  DateTime _lastPressedAt;//上次点击时间

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpackageInfo();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Center(
      child: Text("你好啊啊啊啊啊"),
    ),
        onWillPop: exitapp);
  }

  /**
   * 退出app
   */
  Future<bool> exitapp(){
if(_lastPressedAt==null||DateTime.now().difference(_lastPressedAt)>Duration(seconds: 2))
    Fluttertoast.showToast(
        msg: "再按一次推出应用！！！！！！！！！！",
       toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      fontSize: 13
    );
  }

  void getpackageInfo() async{
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    var appName = packageInfo.appName;
    var packageName = packageInfo.packageName;
    var version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    print("appname:$appName,packageName$packageName,version$version,buildNumber$buildNumber");

  }
}

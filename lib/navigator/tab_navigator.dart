import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterxiecheng/pages/home_pages.dart';
import 'package:flutterxiecheng/pages/my_pages.dart';
import 'package:flutterxiecheng/pages/serach_pages.dart';
import 'package:flutterxiecheng/pages/travel_pages.dart';
import 'package:package_info/package_info.dart';

class Tab_Navigator extends StatefulWidget {
  @override
  _Tab_NavigatorState createState() => _Tab_NavigatorState();
}

class _Tab_NavigatorState extends State<Tab_Navigator> {
  DateTime _lastPressedAt; //上次点击时间
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: PageView(
            controller: _controller,
            children: <Widget>[
              HomePage(),
              SerachPage(),
              TravelPage(),
              MyPage()
            ],
           onPageChanged: (index){
             setState(() {
               _currentIndex = index;
             });
           },
          ),
          onWillPop: exitapp),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _bottomItem(Icons.home, "首页", 0),
          _bottomItem(Icons.search, "搜索", 1),
          _bottomItem(Icons.camera_alt, "旅拍", 2),
          _bottomItem(Icons.account_circle, "我的", 3),
        ],
        currentIndex: _currentIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  /**
   * 退出app
   */
  Future<bool> exitapp() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      Fluttertoast.showToast(
        msg: "再按一次推出应用！！！！！！！！！！",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        fontSize: 13,
      );
//两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void getpackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var appName = packageInfo.appName;
    var packageName = packageInfo.packageName;
    var version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    print(
        "appname:$appName,packageName$packageName,version$version,buildNumber$buildNumber");
  }

  BottomNavigationBarItem _bottomItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: (Icon(
          icon,
          color: _defaultColor,
        )),
        activeIcon: (Icon(
          icon,
          color: _activeColor,
        )),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }

  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
}

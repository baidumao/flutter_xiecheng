import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_xiecheng',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Tab_Navigator()
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutterxiecheng/model/gridnav_model.dart';
import 'package:flutterxiecheng/widget/cached_image.dart';
import 'package:flutterxiecheng/widget/webview.dart';
class SubNav extends StatelessWidget {
  List<CommonModel> subNavList;
  SubNav( this.subNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
     color: Colors.white,
        borderRadius: BorderRadius.circular(6)
      ),
         child: Padding(padding: EdgeInsets.all(7),
         child: _items(context),
),
    );
  }

  Widget _items(BuildContext context){
    if(subNavList==null) return null;
    var list = subNavList.map((model){
     return _item(context, model);
    }).toList();
    //计算出第一行显示的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
return Column(
  children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list.sublist(0,separate),
    ),
    Padding(padding: EdgeInsets.only(top: 3),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list.sublist(separate, subNavList.length),
        )

    )
  ],
);

  }
  Widget _item(BuildContext context,CommonModel model){
   return Expanded(
       child: GestureDetector(
         onTap: (){
           Navigator.push(context,MaterialPageRoute(builder: (context){
             return WebView(url: model.url,statusBarColor: model.statusBarColor,title: model.title,hideAppBar: model.hideAppBar);
           }));
         },
         child: Column(
      children: <Widget>[
        CachedImage(
          imageUrl: model.icon,
          width: 18,
          height: 18,
        ),
        
        Padding(padding: EdgeInsets.only(top: 3),
          child: Text(model.title,
          style: TextStyle(
               fontSize: 12
          ),
          ),
        )

      ],
         ),
       )

   );

  }
}

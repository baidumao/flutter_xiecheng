import 'package:flutter/material.dart';
import 'package:flutterxiecheng/model/gridnav_model.dart';
import 'package:flutterxiecheng/widget/cached_image.dart';
import 'package:flutterxiecheng/widget/webview.dart';
class LocalNav extends StatelessWidget {
  List<CommonModel> localNavList;

  LocalNav(this.localNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(
       color: Colors.white,
        borderRadius:BorderRadius.circular(6)
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child:_items(context) ,
      ),

    );
  }

  Widget _items(BuildContext context) {
    if(localNavList==null) return null;
    var list = localNavList.map((model){
      return _item(context, model);
    }).toList();

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );;

  }
  Widget _item(BuildContext context,CommonModel model){
     return GestureDetector(
       child: Column(
         children: <Widget>[
          CachedImage(imageUrl: model.icon,
          fit: BoxFit.fill,
            width: 32,
            height: 32,
          ),
           Text(model.title,
           style: TextStyle(
             fontSize:12
           ),
           )
         ],
       ),
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (cotext){
           return WebView(url:model.url,statusBarColor:model.statusBarColor,title:model.title);
         })
         );
       },
     );

  }

}

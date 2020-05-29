import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterxiecheng/dao/travel_dao.dart';
import 'package:flutterxiecheng/model/travel_model.dart';
import 'package:flutterxiecheng/widget/cached_image.dart';
import 'package:flutterxiecheng/widget/loading_container.dart';
import 'package:flutterxiecheng/widget/webview.dart';

const TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;
  final int type;


  TravelTabPage({this.travelUrl, this.params, this.groupChannelCode, this.type});

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  int pageIndex = 1;
  bool _loading = true;
  List<TravelItem> travelItems;
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });


  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
          child: RefreshIndicator(
              child: MediaQuery.removePadding(
                  context: context,
                  child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      controller: _scrollController,
                      itemBuilder: (context,index){
                        return _TravelItem(index,travelItems[index]);
                      },
                      itemCount: travelItems?.length ?? 0,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1))),
              onRefresh: _handleRefresh),
          ),
    );
  }
  //下拉刷新
  Future<Null> _handleRefresh() async {
    _loadData();
    return null;
  }
  //获取数据
  void _loadData({loadMore = false})async{
    if(loadMore){
      pageIndex++;
    }else{
      pageIndex=1;
    }

    try{
      TravelModel model= await TravelDao.fetch(
        widget.travelUrl ?? TRAVEL_URL,
        widget.params,
        widget.groupChannelCode,
        widget.type,
        pageIndex,
        PAGE_SIZE
      );

      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
        _loading=false;
      });
    }catch(e){
      print(e);
      setState(() {
        _loading = false;
      });
    }


  }


  //数据过滤
  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  Widget _TravelItem(int index, TravelItem item) {
    return GestureDetector(
      onTap: (){
        if(item.article.urls!=null&&item.article.urls.length>0){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return WebView(url: item.article.urls[0].h5Url,title: "详情");
          }));
        }
      },

      child: Card(
        child: PhysicalModel(color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(item),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText(item)
            ],
          ),
        ),
      ),
    );
  }

 Widget  _itemImage(TravelItem item) {
    return Stack(
      children: <Widget>[
        CachedImage(
          inSizedBox: true,
          imageUrl: item.article.images[0]?.dynamicUrl,
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
               LimitedBox(
                 maxWidth: 130,
                 child: Text(
                   _poiName(item),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(fontSize: 12, color: Colors.white),
                 ),
               )
              ],
            ),
          ),
        )

      ],
    );
 }

  String _poiName(TravelItem item) {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }

 Widget _infoText(TravelItem item) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
   children: <Widget>[
     Row(
       children: <Widget>[
         PhysicalModel(
           color: Colors.transparent,
           clipBehavior: Clip.antiAlias,
           borderRadius: BorderRadius.circular(12),
           child: CachedImage(
             imageUrl: item.article.author?.coverImage?.dynamicUrl,
             width: 24,
             height: 24,
           ),
         ),
         Container(
           padding: EdgeInsets.all(5),
           width: 90,
           child: Text(
             item.article.author?.nickName,
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(fontSize: 12),
           ),
         ),
      Row(
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            size: 14,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              item.article.likeCount.toString(),
              style: TextStyle(fontSize: 10),
            ),
          )
        ],

      )
       ],
     ),
   ],
      ),
    );
  }

}

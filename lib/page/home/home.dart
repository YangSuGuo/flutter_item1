import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:item_1/common/utils/custom_animated_bottom_bar.dart';
import 'package:item_1/http/net.dart';

// todo 将页面划分层，网络请求数据层，UI层，UI实现层
// todo 至少吧一堆小部件分开处理

// todo 浮动分类选择器【样式未知】
// todo 滑动选择【手势适配】
// todo 功能分类栏
// todo 数据分类，ListView的水平滑动图标按钮【知乎日报、科技、编程、公告、自然、校园、动漫、游戏】
// todo 选中将_getItem中数据重新获取并渲染

// todo 1.列表化卡片
// todo 2.dio网络请求渲染，加载占位图，请求的网络数据，格式化？并传入_getItem
// todo 【可选：将请求内容【包括图片】存入缓存，避免重复请求渲染】
// todo 3.索引列表点击，获取文章id，请求文章详情
// todo 4.手势适配，下拉刷新，分页处理无限下划【可选】
////////////////////[学习]/////////////////////////////
// todo 5.flutter 路由，夜间模式
// todo 6.flutter 数据持久化存储，缓存
// todo 7.flutter 压缩包体积，网络api，本机api
// todo GestureDetector包裹用于处理点击事件并传值item【id】来获取正文内容

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0; // 底部导航栏索引
  final _inactiveColor = Colors.grey; // 非激活颜色
  late Future<List<Map<String, dynamic>>> _itemsFuture; // 知乎日报
  // todo 日报精选

  @override
  void initState() {
    super.initState();
    _itemsFuture = _getList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 821 - 44 - 34),
    );

    return Scaffold(
        appBar: _buildAppBar(),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  // appbar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'NEWS',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: Colors.black, letterSpacing: 8),
      ),
    );
  }

  // Body
  Widget getBody() {
    List<Widget> pages = [
      _buildBody(),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Hot",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "User",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Settings",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  // 自定义底部导航栏
  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 66,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 50,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home '),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.bar_chart),
          title: Text('Hot '),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text(
            'User ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings '),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // list
  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // todo 骨架屏 ps：时间好短，不如不做，想加个延迟都去看骨架屏
              return SliverToBoxAdapter(
                  child: Column(
                children: [
                  SizedBox(height: 20), // 增加200的高度
                  GFShimmer(
                    duration: const Duration(milliseconds: 1000),
                    child: emptyBlock,
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                  // todo 提示弹框【无网络】
                  // todo 调用本地缓存加载列表
                  child: Text('无网络'));
            } else {
              final items = snapshot.data!;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        // todo 点击事件
                        behavior: HitTestBehavior.translucent,
                        child: _getItem(items[index]),
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              );
            }
          },
        )
      ],
    );
  }

  // 获取数据
  Future<List<Map<String, dynamic>>> _getList() async {
    try {
      final response = await DioUtils.instance.dio.get(HttpApi.zhihu_list);
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data['stories'].cast<Map<String, dynamic>>();

        final List<Map<String, dynamic>> selectedItems =
            data['top_stories'].cast<Map<String, dynamic>>();
        return items;
      } else {
        throw Exception('加载数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }

  // 列表
  Widget _getItem(Map<String, dynamic> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/image/loading.gif',
            image: item['images'][0],
            fit: BoxFit.cover,
            width: 140,
            height: 90,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // 主要文本
            children: <Widget>[
              SizedBox(height: 8),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(height: 20),
                    Expanded(
                      child: Text(item['title'],
                          softWrap: true,
                          maxLines: 2,
                          // overflow
                          style: getStyle(Colors.black, 15.0, bold: true)),
                      // SizedBox(height: 2.4),
                    )
                  ]),
              SizedBox(height: 2.4),
              Container(
                height: 50,
                child: Text(item['hint'],
                    softWrap: true,
                    maxLines: 3,
                    style: getStyle(Colors.grey, 13.0)),
              ),
              // 数据标签
              Row(textDirection: TextDirection.rtl, children: <Widget>[
                Icon(
                  Icons.sentiment_satisfied_outlined,
                  size: 12.4,
                ),
                SizedBox(width: 2.4),
                Text(item['id'].toString(),
                    softWrap: false, style: getStyle(Colors.grey, 12.4)),
              ])
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }

// 字体样式
  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

  // 骨架屏
  final Widget emptyBlock = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140,
          height: 100,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 24,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: 150,
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: 100,
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: 20,
                height: 8,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:item_1/common/utils/custom_animated_bottom_bar.dart';
import 'package:item_1/http/zhihu_api.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _itemIndex = 0;
  int _currentIndex = 0; // 底部导航栏索引
  final _inactiveColor = Colors.grey; // 非激活颜色

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 821 - 44 - 34),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          // toolbarHeight: 65,
          title: const Text(
            'NEWS',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 25, color: Colors.black, letterSpacing: 8),
          ),
        ),
        //顶部导航栏

        body: CustomScrollView(slivers: [
          const SliverAppBar(
            // todo 浮动分类选择器【样式未知】
            // todo 滑动选择【手势适配】
            floating: true,
            stretch: true,
            expandedHeight: 75,
            // todo 功能分类栏
            // todo 数据分类，ListView的水平滑动图标按钮【知乎日报、科技、编程、公告、自然、校园、动漫、游戏】
            // todo 选中将_getItem中数据重新获取并渲染
            flexibleSpace: Image(
              image: NetworkImage(
                'https://tu.ltyuanfang.cn/api/fengjing.php',
              ),
              fit: BoxFit.cover,
            ),
          ),
          // todo 1.列表化卡片
          // todo 2.dio网络请求渲染，加载占位图，请求的网络数据，格式化？并传入_getItem
          // todo 3.索引列表点击，获取文章id，请求文章详情
          // todo 4.手势适配，下拉刷新，分页处理无限下划【可选】
          ////////////////////[学习]/////////////////////////////
          // todo 5.flutter 路由，夜间模式
          // todo 6.flutter 数据持久化存储，缓存
          // todo 7.flutter 压缩包体积，网络api，本机api

          // 其他的 sliver 组件
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {},
              childCount: items.length,
            ),
          ),
        ]),
        //主体
        bottomNavigationBar: _buildBottomBar());
  }

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
                    Text(item['title'],
                        softWrap: true,
                        maxLines: 2,
                        style: getStyle(Colors.black, 15.0, bold: true)),
                    // SizedBox(height: 2.4),
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
              // todo 位置错误，应始终置底，or 固定副标题高度
              // todo 待办
              Row(textDirection: TextDirection.rtl, children: <Widget>[
                Icon(
                  Icons.sentiment_satisfied_outlined,
                  size: 12.4,
                ),
                SizedBox(width: 2.4),
                Text(item['id'],
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
}
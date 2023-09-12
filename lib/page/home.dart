import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:item_1/common/utils/custom_animated_bottom_bar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 821 - 44 - 34),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          elevation: 0,
          // toolbarHeight: 65,
          title: const Text(
            'NEWS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(0, 0, 0, 1),
                letterSpacing: 10),
          ),
/*          leading: IconButton(
            icon: Icon(Icons.dashboard_customize_sharp,color: Colors.black),
            onPressed: (){},
          ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.scatter_plot,color: Colors.black),
                onPressed: () {},
              ),
            ]*/
        ),
        //顶部导航栏

        body: CustomScrollView(slivers: [
          const SliverAppBar(
            // todo 浮动分类选择器【样式未知】
            // todo 滑动选择【手势适配】
            floating: true,
            // todo 功能分类栏
            flexibleSpace: Image(
              image: NetworkImage(
                'https://tu.ltyuanfang.cn/api/fengjing.php',
              ),
              fit: BoxFit.cover,
            ),
            expandedHeight: 75,
          ),
          // todo 1.列表化卡片
          // todo 2.dio网络请求渲染
          // todo 3.索引列表点击，获取文章id，请求文章详情
          // todo 4.手势适配，下拉刷新，分页处理无限下划【可选】
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    // todo 请求的网络数据，格式化？并传入_getItem
                    child: _getItem(index),
                  ),
                );
              },
              childCount: 50, // 列表项的数量
            ),
          ),
        ]),
        //主体

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 11.4,
          unselectedFontSize: 0.0,
          iconSize: 25,
          enableFeedback: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '热榜'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          ],
          //点击事件
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        )); //底部导航栏
  }

  Widget _getItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Image.network(
            'https://tu.ltyuanfang.cn/api/fengjing.php',
            fit: BoxFit.cover,
            width: 140,
            height: 90,
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                    Text('这是一个标题',
                        softWrap: true,
                        maxLines: 2,
                        style: getStyle(Colors.black, 15.0, bold: true)),
                    // todo 对齐问题
/*                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(Icons.sentiment_satisfied_outlined,size: 20,),
                        Text('5409',softWrap: false, style: getStyle(Colors.grey, 12.4))
                      ],
                    ),*/
                    // SizedBox(height: 2.4),
                  ]),
              SizedBox(height: 2.4),
              Column(
                children: [
                  Text(
                      '这是一个副标题000000000000000000000000000000000000000000000000000000000',
                      softWrap: true,
                      maxLines: 3,
                      style: getStyle(Colors.grey, 13.0)),
                ],
              ),
              // 数据标签
              // todo 位置错误，应始终置底，or 固定副标题高度
              Row(textDirection: TextDirection.rtl, children: <Widget>[
                Icon(
                  Icons.sentiment_satisfied_outlined,
                  size: 12.4,
                ),
                SizedBox(width: 2.4),
                Text('5409',
                    softWrap: false, style: getStyle(Colors.grey, 12.4)),
              ])
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
/*        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Icon(Icons.sentiment_satisfied_outlined,size: 20,),
              SizedBox(height: 2.4),
              Text('5409',softWrap: false, style: getStyle(Colors.grey, 12.4)),
            ]
        )*/
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
      containerHeight: 70,
      backgroundColor: Colors.black,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text(
            'Messages ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: Text(
          "Home",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Users",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Messages",
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
}

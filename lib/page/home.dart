import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var _currentIndex = 0;

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
          toolbarOpacity: 0.5,
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
            flexibleSpace: Image(
              image: NetworkImage(
                'https://tu.ltyuanfang.cn/api/fengjing.php',
              ),
              fit: BoxFit.cover,
            ),
            expandedHeight: 50,
          ),
          // todo 1.列表化卡片
          // todo 2.dio网络请求渲染
          // todo 3.索引列表点击，获取文章详情
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                // 卡片
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  // 列表图片
                  // visualDensity: VisualDensity(vertical: 4),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                          'https://tu.ltyuanfang.cn/api/fengjing.php',
                          fit: BoxFit.cover,width: 100,)),
                  title: Text('Item'),
                  subtitle: Text('这是一个副标题'),
                  trailing: Text('浏览量'),
                  dense: false,
                ),
              ),
            ),
          )
        ]),
        //主体

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: '添加'),
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
}

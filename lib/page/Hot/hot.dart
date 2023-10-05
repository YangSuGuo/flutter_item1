import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../../http/net.dart';

class hot extends StatefulWidget {
  @override
  State<hot> createState() => _hotState();
}

class _hotState extends State<hot> {
  DateTime dateTime = DateTime.now(); // 时间
  List<Map<String, dynamic>> items = []; // 知乎日报
  int day = 0; //分页

  @override
  void initState() {
    super.initState();
    // 初始化数据
    InitialData();
  }

  Future<void> InitialData() async {
    try {
      final newItems = await _getList();
      setState(() {
        items.addAll(newItems);
      });
    } catch (e) {
      print('加载初始数据失败: $e');
    }
  }

  // 新鲜的知乎日报
  Future<List<Map<String, dynamic>>> _getList() async {
    try {
      final response = await DioUtils.instance.dio.get(HttpApi.zhihu_list);
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data['top_stories'].cast<Map<String, dynamic>>();
        return items;
      } else {
        throw Exception('加载数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemList = _buildBody();
    return Scaffold(backgroundColor: Color(0xFFF6F8FA), body: itemList);
  }

  // bodyList
  Widget _buildBody() {
    return EasyRefresh(
      // todo 自定义刷新头、尾
      onRefresh: () async {
        // 下拉刷新
        final newItems = await _getList();
        items.clear();
        setState(() {
          items.addAll(newItems);
        });
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 2),
            child: _getItem(items[index]),
          );
        },
      ),
    );
  }

  // 列表
  Widget _getItem(Map<String, dynamic> item) {
    return GestureDetector(
      // todo 点击事件 InkWell
      behavior: HitTestBehavior.translucent,
/*        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPage(itemId: item['id']),
            ),
          );
        },*/
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 75.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/image/loading.gif',
                    image: item['image'],
                    fit: BoxFit.cover,
                    height: 200,
                    width: 360,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 13, left: 13, right: 10),
                  child: Text(
                    item['title'],
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        item['hint'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "文章ID  " + item['id'].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            // 标签说明（二选一）
            Positioned(
              top: 188,
              right: 20.0,
              child: Container(
                color: Colors.pink.withOpacity(0.7),
                padding: const EdgeInsets.all(4.0),
                child: const Text(
                  "知乎日报▪精选",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            /*
            Positioned(
              top: -5,
              right: -5,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)
                    )
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        "知乎日报▪精选",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              )
            )*/
          ],
        ),
      ),
    );
  }

// 字体样式
  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}

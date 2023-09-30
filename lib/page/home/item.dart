import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../http/net.dart';

class item extends StatefulWidget {
  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
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
      final newItems = await _getOldList(dateTime, day);
      setState(() {
        items.addAll(newItems);
      });
    } catch (e) {
      print('加载初始数据失败: $e');
    }
  }

  // 过去的知乎日报
  Future<List<Map<String, dynamic>>> _getOldList(DateTime date, int i) async {
    try {
      final formattedDate = DateFormat('yyyyMMdd').format(date);
      final response =
          await DioUtils.instance.dio.get('stories/before/$formattedDate');
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data['stories'].cast<Map<String, dynamic>>();
        day = i++;
        // 分页，当前刷新页数
        print(i);
        dateTime = date.subtract(Duration(days: i));
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
    return Scaffold(backgroundColor: Colors.white, body: itemList);
  }

  Widget _buildBody() {
    return EasyRefresh(
      onRefresh: () async {
        final newItems = await _getOldList(dateTime, 0);
        setState(() {
          items.addAll(newItems);
        });
      },
      onLoad: () async {
        // 上拉加载更多时，增加页数并请求新数据
        final newItems = await _getOldList(dateTime, day);
        setState(() {
          items.addAll(newItems);
        });
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: _getItem(items[index]),
          );
        },
      ),
    );
  }

  // 列表
  Widget _getItem(Map<String, dynamic> item) {
    return GestureDetector(
        // todo 点击事件
        behavior: HitTestBehavior.translucent,
        child: Row(
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
                height: 100,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // 主要文本
                children: [
                  SizedBox(height: 8),
                  Text(item['title'],
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getStyle(Colors.black, 15.0, bold: true)),
                  SizedBox(height: 2.4),
                  Container(
                    height: 40,
                    child: Text(item['hint'],
                        softWrap: true,
                        maxLines: 3,
                        style: getStyle(Colors.grey, 13.0)),
                  ),
                  // 数据标签
                  Row(children: [
                    Text(item['id'].toString(),
                        softWrap: false, style: getStyle(Colors.grey, 12.4)),
                    SizedBox(width: 2.4),
                    Icon(
                      Icons.sentiment_satisfied_outlined,
                      size: 12.4,
                    )
                  ])
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ));
  }

// 字体样式
  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}

import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../http/net.dart';
import 'body.dart';

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
      final newItems = await _getList();
      setState(() {
        items.addAll(newItems);
      });
    } catch (e) {
      print('加载列表初始数据失败: $e');
    }
  }

  // 新鲜的知乎日报
  Future<List<Map<String, dynamic>>> _getList() async {
    try {
      final response = await DioUtils.instance.dio.get(HttpApi.zhihu_list);
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data['stories'].cast<Map<String, dynamic>>();
        return items;
      } else {
        throw Exception('加载数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }

  // 过去的知乎日报
  Future<List<Map<String, dynamic>>> _getOldList(DateTime date, int i) async {
    try {
      final formattedDate = DateFormat('yyyyMMdd').format(date);
      final response = await DioUtils.instance.dio
          .get(HttpApi.zhihu_oldList + '$formattedDate');
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data['stories'].cast<Map<String, dynamic>>();
        day = i++;
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
    return Scaffold(body: itemList);
  }

  // bodyList
  Widget _buildBody() {
    return EasyRefresh(
      // todo 自定义刷新头、尾
/*      header: Header(
        position: IndicatorPosition.locator,
      ),
      footer: Footer(
        position: IndicatorPosition.locator,
      ),*/
      onRefresh: () async {
        // 下拉刷新
        final newItems = await _getList();
        final oldItems = items.sublist(0, newItems.length);
        // todo listEquals(oldItems, newItems) 结果错误
        print(listEquals(oldItems, newItems));
        if (!listEquals(oldItems, newItems)) {
          items.removeRange(0, oldItems.length);
          setState(() {
            items.insertAll(0, newItems);
          });
        }
      },
      onLoad: () async {
        // 上拉加载
        final oldItems = await _getOldList(dateTime, day);
        setState(() {
          items.addAll(oldItems);
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
        // todo 也可以用点击事件 InkWell
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.to(essay(), arguments: {'id': item['id']});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item['images'] != null && item['images'].isNotEmpty)
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/image/loading.gif',
                  image: item['images'][0],
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            Expanded(
              child: Container(
                  width: 266,
                  height: 108,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 2, left: 3, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // 主要文本
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 5),
                              child: Text(item['title'],
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getStyle(Colors.black, 15.0,
                                      bold: true))),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(item['hint'],
                                  softWrap: true,
                                  maxLines: 3,
                                  style: getStyle(Colors.grey, 13.0)),
                            ),
                          ),
                          // 数据标签
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 3),
                            child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(item['id'].toString(),
                                      softWrap: false,
                                      style: getStyle(Colors.grey, 12.4)),
                                  SizedBox(width: 2.4),
                                  Icon(
                                    Icons.sentiment_satisfied_outlined,
                                    size: 12.4,
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  )),
            )
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

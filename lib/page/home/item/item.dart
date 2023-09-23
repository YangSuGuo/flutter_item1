import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:item_1/http/net.dart';

class item extends StatefulWidget {
  const item({super.key});

  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  late Future<List<Map<String, dynamic>>> _itemsFuture; // 知乎日报
  late Future<List<Map<String, dynamic>>> _itemsSelected; // 日报精选

  @override
  void initState() {
    super.initState();
    _itemsFuture = _getList();
    _itemsSelected = _getStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
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

  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

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

  Future<List<Map<String, dynamic>>> _getStories() async {
    try {
      final response = await DioUtils.instance.dio.get(HttpApi.zhihu_list);
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> selectedItems =
            data['top_stories'].cast<Map<String, dynamic>>();
        return selectedItems;
      } else {
        throw Exception('加载数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }
}

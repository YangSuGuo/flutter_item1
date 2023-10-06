import 'dart:convert';

import 'package:flutter/material.dart';

import '../../http/net.dart';

class essay extends StatefulWidget {
  @override
  State<essay> createState() => _essayState();
}

class _essayState extends State<essay> {
  List<Map<String, dynamic>> items = []; // 文章正文
  int id = 0; //分页

  @override
  void initState() {
    super.initState();
    // 初始化数据
    InitialData();
  }

  Future<void> InitialData() async {
    try {
      final Body = await _getBody(id);
      setState(() {
        items.addAll(Body);
      });
    } catch (e) {
      print('加载初始数据失败: $e');
    }
  }

  // 获取文章正文
  Future<List<Map<String, dynamic>>> _getBody(int id) async {
    try {
      final response =
          await DioUtils.instance.dio.get(HttpApi.zhihu_body + '$id');
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final List<Map<String, dynamic>> items =
            data.cast<Map<String, dynamic>>();
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
    return Scaffold(
        body: Stack(children: [
      // 图片
      SizedBox(
          height: 480,
          child: Image.asset(
            'assets/image/info.jpg',
            fit: BoxFit.cover,
          )),
      // 按钮
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          MaterialButton(
            padding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            textColor: Colors.black,
            minWidth: 0,
            height: 40,
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
        ]),
      ),
      ListView(children: [
        const SizedBox(height: 400),
        Container(
          height: MediaQuery.of(context).size.height - 230.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // todo 文章详情，富文本！
          ]),
            )
          ])
        ]));
  }

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:item_1/page/home/item.dart';
import 'package:item_1/page/login/login.dart';
import 'package:photo_view/photo_view.dart';

import '../../http/net.dart';
import 'widget/PhotoViewSimpleScreen.dart';

// todo 如果flutter富文本不可以，就改为直接访问网页"url": "https://daily.zhihu.com/story/#{id}"

class essay extends StatefulWidget {
  @override
  State<essay> createState() => _essayState();
}

class _essayState extends State<essay> {
  Map<String, dynamic> items = {}; // 文章正文
  int id = 9766161; // 初始值 id
  int page = 1;

  @override
  void initState() {
    super.initState();
    // 初始化数据
    // todo 需要加载动画！！
    print("获取传值:${Get.arguments["id"]}");
    id = Get.arguments["id"];
    InitialData();
  }

  Future<void> InitialData() async {
    try {
      final body = await _getBody(id);
      setState(() {
        items = body;
      });
    } catch (e) {
      // todo 弹框提示 无网络！！
      print('加载文章正文初始数据失败: $e');
    }
  }

  // 获取文章正文
  Future<Map<String, dynamic>> _getBody(int id) async {
    try {
      final response =
          await DioUtils.instance.dio.get(HttpApi.zhihu_body + '$id');
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        /*final List<Map<String, dynamic>> items =
            data.cast<Map<String, dynamic>>();*/
        return data;
      } else {
        throw Exception('获取数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(children: [
      // 图片
      if (items['image'] != null)
        SizedBox(
            height: 370,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/image/loading.gif',
              image: items['image'],
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            )),
      // 按钮
/*      Padding(
        padding: const EdgeInsets.only(top: 40.0,left: 8),
        child: Row(children: [
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            child: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ]),
      ),*/
      // 内容显示区
      ListView(children: [
        const SizedBox(height: 270),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 文章标题
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                    child: Text(
                      items['title'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 时间日期
                  if (items['publish_time'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                items['publish_time'] * 1000))
                            .toString(),
                        /*items['publish_time'].toString(),*/
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  // 文章正文
                  if (items['title'] != null && items['body'] != null)
                    Html(
                      data: items['body'] ??
                          """
                    <div style='height: 100vh'></div>
                    """,
                      style: {
                        // 图片描述文本置灰
                        "figcaption": Style(
                            margin: Margins(
                                top: Margin(8, Unit.px),
                                left: Margin(8, Unit.px)),
                            color: Colors.grey),
                        // 隐藏前广告
                        "div.meta": Style(display: Display.none),
                        // 段落首行缩进
                        "p": Style(),
                        // 图片处理
                        'img': Style()
                      },
                      extensions: [
                        // TableHtmlExtension(),
                        // VideoHtmlExtension(),
                        OnImageTapExtension(
                          onImageTap: (src, imgAttributes, element) {
                            // todo 图像点击逻辑
                            print('图片链接：' + src.toString());
                            Get.to(PhotoViewSimpleScreen(),
                                arguments: {'src': src}

/*                                Builder(
                                builder:(_)=> Container(
                                child: PhotoView(
                                  imageProvider: NetworkImage(src!),
                                  minScale: 0.5,
                                  maxScale: 1.5,
                                )
                            ))*/

                                );
                          },
                        ),
                        // 排除标签，并替换
                        TagExtension.inline(
                            // 排除所有链接
                            tagsToExtend: {"a"},
                            child: TextSpan(text: "")),
                      ],
                    )
                  else
                    Container(alignment: Alignment.center, child: Text('')),
                ],
              ),
            )),
      ])
    ]);
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_svg/flutter_html_svg.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

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
        return data;
      } else {
        throw Exception('获取正文数据失败');
      }
    } catch (e) {
      throw Exception('错误：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: items.isEmpty ? GFLoader() : _buildBody());
  }

  Widget _buildBody() {
    return Stack(children: [
      // 图片
      SizedBox(
          height: 380,
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 文章标题
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 20, right: 15),
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
                      padding: const EdgeInsets.only(top: 5, left: 25),
                      child: Text(
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                items['publish_time'] * 1000))
                            .toString(),
                        /*items['publish_time'].toString(),*/
                        style: TextStyle(
                          color: Colors.grey, fontSize: 18.0),
                      ),
                    ),
                  // 文章正文
                  // todo 段落首行缩进 主要文字基本为<p>,需要格式化但是排版就成问题了
                  // todo 暂且不知道知乎日报的表格处理
                  // todo blockquote 标签样式参考https://daily.zhihu.com/story/9766035
                  // todo 显示原网页
                  // todo 链接跳转事件
                  // bug 优先级高的内联样式可能会导致溢出，会有部分不可见[宽度：500] 图片！！
                  // bug 图片点击区域点击可能会失效 原因不明！
                  // bug 知乎日报数学符号是用<img>加载svg，不支持！！ 【也许可以用自定义渲染解决】
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Html(
                        data: items['body'],
                        style: {
                          // 图片描述文本置灰
                          "figcaption": Style(
                              margin: Margins(
                                  top: Margin(8, Unit.px),
                                  left: Margin(8, Unit.px)),
                              color: Colors.grey),
                          // 摘要访谈
                          'blockquote': Style(
                            margin: Margins(
                                right: Margin(20, Unit.px),
                                left: Margin(20, Unit.px)),
                            color: Colors.grey,
                          ),
                          // 隐藏前后广告
                          "div.meta": Style(display: Display.none),
                          "div.view-more": Style(display: Display.none),
                          // 表格基本样式
                          "table": Style(
                            backgroundColor:
                                const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          ),
                          "th": Style(
                            padding: HtmlPaddings.all(6),
                            backgroundColor: Colors.grey,
                          ),
                          "td": Style(
                            padding: HtmlPaddings.all(6),
                            border: const Border(
                                bottom: BorderSide(color: Colors.grey)),
                          ),
                        },
                        extensions: [
                          const TableHtmlExtension(),
                          const SvgHtmlExtension(),
                          // 自定义 table
                          TagWrapExtension(
                              tagsToWrap: {"table"},
                              builder: (child) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: child,
                                );
                              }),
                          // 点击图片
                          OnImageTapExtension(
                              onImageTap: (src, imgAttributes, element) {
                            print('图片链接：' + src.toString());
                            Get.to(PhotoViewSimpleScreen(),
                                arguments: {'src': src});
                          }),
                          // 排除标签，并替换
                          TagExtension.inline(
                              tagsToExtend: {'script'},
                              child: TextSpan(text: "")),
                        ],
                        // css错误
                        onCssParseError: (css, messages) {
                          debugPrint("css that errored: $css");
                          debugPrint("error messages:");
                          for (var element in messages) {
                            debugPrint(element.toString());
                          }
                          return '';
                        },
                      ))
                ],
              ),
            )),
      ])
    ]);
  }
}

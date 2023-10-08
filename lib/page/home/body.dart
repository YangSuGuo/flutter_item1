import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../http/net.dart';

// todo 如果flutter富文本不可以，就改为直接访问网页"url": "https://daily.zhihu.com/story/#{id}"

class essay extends StatefulWidget {
  @override
  State<essay> createState() => _essayState();
}

class _essayState extends State<essay> {
  List<Map<String, dynamic>> items = []; // 文章正文
  int id = 0;

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
  /*
  "body": ""
  "image_hue": "0x634c46",
  "publish_time": 1694732460,
  "title": "海洋中为什么使用海里这一单位？",
  "url": "https://daily.zhihu.com/story/9765443",
  "image": "https://pic1.zhimg.com/v2-b33c1a6045f5124b34ca42c0c3a2ecd2.jpg?source=8673f162",
  "share_url": "http://daily.zhihu.com/story/9765443",
  "js": [],
  "create_time": 1694672485,
  "ga_prefix": "091507",
  "images": [
  "https://picx.zhimg.com/v2-40caf11b202d03de0ba7a97b211bbfea.jpg?source=8673f162"
  ],
  "type": 0,
  "id": 9765443,
  "css": [
  "http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3"
  ]
  */
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
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(children: [
      // 图片
      SizedBox(
          height: 370,
          child: Image.asset(
            /*item['image'],*/
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
        const SizedBox(height: 270),
        Container(
            height: 358 - 230.0,
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
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                      child: Text(
                        /*item['title'],*/
                        '海洋中为什么使用海里这一单位？',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // 时间日期
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 13, left: 5),
                      child: Text(
                        /*item['publish_time']*/
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                1694732460 * 1000))
                            .toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ]),
            )),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(padding: const EdgeInsets.all(20), child: Html(
                    /*item['body'],*/
                    data: """
            <div class=\"content\"><p>可以，但没必要，也很难做到。</p>\r<p><strong>由于城墙≠城市范围，所以大多数古代城市的真实情况是，城墙内有大片农田、湖泊等未建成区，与此同时城墙外有大量居住区、商业区。</strong>
            </p>\r<p>
                以清代顺天府地区部分城市为例，图中蓝线代表城墙范围，黄色区域代表城市建成区，不难看出，这些城市的城墙范围和城区范围都有相当大的差异。</p>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://pica.zhimg.com/v2-11c7b3793223f11770f119fa90b63fb5_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>清代二级行政区治所城郭简图直隶篇。图片来自知乎@吡啶</figcaption>
                </figure>
                \r<p>
                    造成这种现象的原因其实并不难理解：<strong>城墙是防御设施，但城市本身的职能是居住、贸易、交通，功能的差异导致城墙和城市几乎不可能同步发展。</strong>
                </p>\r<p>
                    受限于地形、建造成本、以及城市用水和食物供应方面的考虑，城墙往往只会围住一部分城市建成区并且在墙内圈出一大片农村；而城市受限于城墙对交通的阻碍，往往会在城门内外以及城墙下“生长”出一条条狭长的建成区，便于贸易和服务活动的开展。</p>
                \r<p>
                    <strong>所以从表象来看，中国古代城市的一个特点是“城外有城，城内有村”。实际上，城墙压根不等于城市范围。</strong>
                </p>\r<p>
                    修城墙的时候，人们往往要在墙内留几个“海子”也就是湖，这些湖可以为城内居民提供水和湖畔耕地。例如北京的什刹海，在元明清时期周边都种过水稻，后来随着清代人口增长和城市开发才变成今天的商业区。北京附近的通州城也有两个湖，分别名叫东海子和西海子，现代改造之后东海子消失了，西海子成了公园。</p>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-cc59f68554f755204bce5cd2209b1765_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>河南安阳旧城，城墙内比较大的湖泊有五六处。</figcaption>
                </figure>
                \r<p>
                    有些大片的空地除了种粮食，还可以用来种菜、取土烧砖、埋人。比如北京南城的南菜园（大观园附近）听名字就知道做啥的，陶然亭公园那个大湖其实最早是百姓取土挖出来的坑，周边都是坟地。</p>
                \r<p>
                    城市发展之后，这些空地也不一定变成居民区。毕竟商业街也好，贫民窟也罢，都不是自动扩散的无机盐，它们都遵循交通规律往便利的地方发展，结果就是在城门内外形成了柱状或锥状的关厢。</p>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://pica.zhimg.com/v2-622ffde2dfc92ce6b0b12e2f3ba6f9f1_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>清代二级行政区治所城郭简图山东篇。图片来自知乎@吡啶</figcaption>
                </figure>
                \r<p>
                    关厢的规模可大可小，有时可以非常庞大。例如元朝废弃金中都，在东北方新建大都之后，大都丽正门和废都居民区之间就形成了一大片斜向的关厢。明朝北京保卫战时，还有关厢地区的居民站在房顶上用杂物投掷路过的瓦剌士兵。嘉靖年间修筑北京外城后，这个地区才被包进墙内。</p>
                \r<p>
                    还有些城市由于经费不足，只能修建规模很小的城墙，导致大片建成区都在城墙之外。还有些城市比如河北沧州由于担心水患，刻意收缩了城墙范围，就把一些居民区留在了城墙外。</p>
                \r<p>有的关厢“生长”起来之后，可以达到与原城市媲美的规模，最典型的例子是山东潍县（今潍坊市区）。</p>\r
                <figure><img class=\"content-image\"
                             src=\"https://pic1.zhimg.com/v2-3a22bbc2b5eef700ed6b395713239783_720w.jpg?source=8673f162\"
                             alt=\"\"></figure>
                \r<p>
                    如图所示，潍县是由两个市镇组成的，其实只有西边那个方形的城市才是潍县的“本体”，东边那个名叫东关坞，是个因贸易和水运发展起来的建成区。直到清晚期，东关坞都没有城墙，后来出于防备捻军的需求，官员和士绅才集资为东关坞修建了城墙。</p>
                \r<p>然而东关坞有了城墙之后，潍县仍然有一部分城区是露在城墙之外的。<strong>修城墙是件费钱的事，把整个城市围起来并不划算，也不一定适应防御需求。</strong>
                </p>\r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-da602e9e03627cfcde5030919d430b83_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>
                        清代二级行政区治所城郭简图江苏篇。图片来自知乎@吡啶。观察苏州和常州可知，发达的商业能催生出规模巨大的关厢。
                    </figcaption>
                </figure>
                \r<p>近代铁路出现后，火车站对关厢发展的推动作用更是惊人，例如京张铁路通车直接把西直门外关厢变成了北京城外规模最大的建成区。在某种意义上，石家庄最初也是正定的“关厢”，最终却借着铁路发展成了
                    20 世纪以来全中国扩张速度最快的城市，反过来“吞噬”了正定。</p>\r<p><strong>城墙≠城市范围的规律当然不只适用于中国，全世界古代城市都有“城乡不定界”的特点。</strong>
                </p>\r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-6d56d747567b148e23dcc1a522233d70_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>殖民地时期秘鲁的“三王之城”利马，城墙外有城区，城墙内有农田。</figcaption>
                </figure>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-1a672fc48f045100c1b8a041d7a15941_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>1700 年的伦敦，城墙范围相对城区小得可怜。</figcaption>
                </figure>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-1c89988546d9d969a98906bbb3b82565_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>1549 年的开罗，即使巅峰已过也没有坍缩到城墙范围内。</figcaption>
                </figure>
                \r<p>有些地区例如东南亚，在欧洲人到来之前压根没有修城墙的习惯，导致学者对 12 世纪吴哥的城市人口估计最高达到
                    100 万——这个数字其实是大片城乡骈连在一起的结果。</p>\r<p>
                    那么，世界历史上有没有试图修筑城墙把整个城市围起来的例子呢？答案是有的，那就是巴黎。</p>\r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-9aa4df439cbca8b99c58cab5ea113741_720w.jpg?source=8673f162\"
                             alt=\"\"></figure>
                \r<p>
                    巴黎这么做的后果就是得不断修建新城墙，因为贫民始终会在城墙地区形成新定居区，即使立法禁止也不管用。墙是死的，人是活的，这场斗争只能以墙的失败告终。</p>
                \r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-5e4fc9428937fdec742a39322798e7da_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>接触欧洲人后东南亚人也开始修筑城墙。图中是曼谷城墙，18 世纪末修建的第一重城墙在 19
                        世纪上半叶就开始包裹不住不断膨胀的城市了。1852 年，拉玛四世下令修建第二重城墙。
                    </figcaption>
                </figure>
                \r<p>
                    在“罗马治下的和平”时期，罗马帝国的众多城市并不修建城墙。到了风雨飘摇的帝国晚期，城市们纷纷拆除纪念碑、竞技场，用腾出来的材料修建了宏伟的城墙。“黑暗时代”到来后，由于城市的坍缩，这些城墙大多被废弃，以修道院和城堡为中心的小范围工事承担了防御职能。<strong>城墙和城市的范围在任何时期都在伸缩，也呈现出一定的同步性，但它们往往并不重合。</strong>
                </p>\r
                <figure><img class=\"content-image\"
                             src=\"https://picx.zhimg.com/v2-2e5362a724f0b9267c1fcb474b44e0ef_720w.jpg?source=8673f162\"
                             alt=\"\">
                    <figcaption>罗马城墙。“黑暗时代”到来后，哈德良城墙内的空荒面积更大了。17
                        世纪之后，罗马教宗才在城市西部修建新城墙，把自己的领地纳入城墙范围内。
                    </figcaption>
                </figure>
                \r<p>
                    所谓“筑城以卫君，造廓以守民”，城墙追求的永远是以最高效率满足防御需求，但它并不能约束作为一个经济体的城市。</p>
                \r<p><strong>特别是 11
                    世纪以来，世界各地的城市先后出现了从消费型城市向生产型城市的转变，交通和贸易的作用相对统治和防御功能也越来越重要，城墙和城市的关系就更加淡漠了。</strong>
                </p>\r<p>
                    在《圣经》当中，以色列人凭借号角和喊叫，靠神迹摧毁了耶利哥的城墙。但是在真正的历史当中，能够摧毁世界上所有城墙的唯一“神迹”，就是人类在过去一千年当中取得的经济进步。</p>
                
            </div>
            
        </div>
        """))))
      ])
    ]);
  }
}

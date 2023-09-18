import 'dart:convert';

import 'package:item_1/generated/json/base/json_field.dart';
import 'package:item_1/generated/json/zhihu_body_entity.g.dart';

export 'package:item_1/generated/json/zhihu_body_entity.g.dart';

/*
{
"body": "<div class=\"main-wrap content-wrap\">\n<div class=\"headline\">\n\n<div class=\"img-place-holder\"></div>\n\n\n\n</div>\n\n<div class=\"content-inner\">\n\n\n\n\n<div class=\"question\">\n<h2 class=\"question-title\"></h2>\n\n<div class=\"answer\">\n\n<div class=\"meta\">\n<img class=\"avatar\" src=\"https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=8673f162\">\n<span class=\"author\">笨笨</span>\n<a href=\"https://www.zhihu.com/question/368834763/answer/2656664459\" class=\"originUrl\" hidden>查看知乎原文</a>\n</div>\n\n<div class=\"content\">\n<p>在人类刚开始远洋航行的时候，如何准确地描述海上的距离一度成为了一大难题，因为在茫茫的海洋中，人们根本无法找到合适的参照物，而在顺流、逆流等多种因素的干扰下，人们也无法准确地判断出船只在大海上航行的速度。</p>\r\n<p>在进入了 16 世纪之后，人们已经可以通过各种航海仪器较为准确地测量出自己在大海中所在的经纬度，在此基础上，就有人提出了一种利用经纬度来定义海洋中的基础距离单位的观点。</p>\r\n<figure><img class=\"content-image\" src=\"https://pica.zhimg.com/v2-61b632d89033cd21b844d2c3572cf2f9_720w.jpg?source=8673f162\" alt=\"\"></figure>\r\n<p>早在公元前 5 世纪左右，人们就开始猜测地球很可能是圆的，在人类具备了远洋航行的能力之后，这种说法就逐渐得到了人们的认同。</p>\r\n<p>所以该观点认为，假设地球是一个完美的球体，那么在地球表面上的任意一点，都可以画出一个穿过地球北极点和南极点的大圆（注：大圆就是通过球体中心的平面和球体表面的交线），由于这种大圆其实就是两条相对的经线连起来的，所以我们可以将其称为“经线圈”。</p>\r\n<figure><img class=\"content-image\" src=\"https://pic1.zhimg.com/v2-6485fc24d69dfa937db6ea90203e4146_720w.jpg?source=8673f162\" alt=\"\"></figure>\r\n<p>从理论上来讲，我们可以在地球表面画出无数个“经线圈”，但它们都有一个共同的特点，那就是它们的周长是相等的，所以我们只需要将“经线圈”的周长进行合理的划分，就可以定义出基础距离单位。</p>\r\n<p>怎么划分呢？其实很简单，“经线圈”就是一个圆，所以我们可以把这个圆分成 360 度，然后将每一度再分为 60 分，而这个 1 分所对应的弧长，就可以作为描述海上距离的基础单位了。</p>\r\n<p>是的，你没有猜错，这其实就是“海里”的由来，我们可以简单地将其理解为，将上述“经线圈”的周长除以 360，然后再除以 60，得到的长度就是 1 海里。那么 1 海里是多少公里呢？我们接着看。</p>\r\n<figure><img class=\"content-image\" src=\"https://picx.zhimg.com/v2-24bd3ecb64a8b33a235cb2e5e4559d5d_720w.jpg?source=8673f162\" alt=\"\"></figure>\r\n<p>1 公里就是 1 千米，这是我们都知道的，而关于米的定义，则要追溯到 1799 年，在这一年里，法国正式开始使用一种被称为“米制”的度量衡标准，该标准将 1 米的长度定义为：“通过巴黎的经线上从地球北极点到地球赤道的距离的 1 千万分之 1”。</p>\r\n<p>在接下来的时间里，“米制”逐渐得到了广泛的采纳，为了精确地表示 1 米的长度，人们可谓是想尽了办法，但在实际应用中总是会存在着一定的误差，直到科学家能够非常精确地测定光速之后，这一问题才得到解决，于是 1 米的长度最终被定义为：“光在真空中直线前进 299792458 分之 1 秒的距离”。</p>\r\n<figure><img class=\"content-image\" src=\"https://pica.zhimg.com/v2-0ccbcf6b6595646235135953b82db512_720w.jpg?source=8673f162\" alt=\"\"></figure>\r\n<p>现在我们假设地球是一个完美的球体，那么按此标准就可以得出，“通过巴黎的经线上从地球北极点到地球赤道的距离”，其实就是上述“经线圈”周长的 4 分之 1，所以“经线圈”的周长就为 4 千万米，也就是 4 万公里。</p>\r\n<figure><img class=\"content-image\" src=\"https://picx.zhimg.com/v2-eb506ef644297da3a86c42df5ee96463_720w.jpg?source=8673f162\" alt=\"\"></figure>\r\n<p>根据海里的定义就可以计算出，1 海里就等于 4 千万米除以 360 然后再除以 60，其结果就是大约 1852 米，也就是说，1 海里大约是 1.852 公里。</p>\r\n<p>然而地球却并不是一个完美的球体，这就意味着，地球上不同纬度的区域，1 海里的距离就会存在着一定的差异，比如说在赤道区域，1 海里大约是 1.843 公里，而在两极区域，1 海里大约是 1.862 公里。</p>\r\n<p>在这种情况下，地球上各个区域对“1 海里是多少公里”的定义就出现了不同，但一般来讲，人们普通采用的是 1929 年国际水文地理学会议上通过的标准，而根据该标准的定义，1 海里就是 1.852 公里。</p>\r\n<p>总而言之，“海里”出现得比“公里”更早，而因为用海里这种与地球尺寸直接相关的单位，可以简洁而直观地描述船只在大海上的行程，再加上这种单位人们用了很久，早就已经习惯了，所以直到现在，人们通常还是用海里来描述海上的距离，而不是用公里。</p>\n</div>\n</div>\n\n\n<div class=\"view-more\"><a href=\"https://www.zhihu.com/question/368834763\">查看知乎讨论<span class=\"js-question-holder\"></span></a></div>\n\n</div>\n\n\n</div>\n</div><script type=“text/javascript”>window.daily=true</script>",
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
}
*/

@JsonSerializable()
class ZhihuBodyEntity {
  late String body;
  @JSONField(name: "image_hue")
  late String imageHue;
  @JSONField(name: "publish_time")
  late int publishTime;
  late String title;
  late String url;
  late String image;
  @JSONField(name: "share_url")
  late String shareUrl;
  late List<dynamic> js;
  @JSONField(name: "create_time")
  late int createTime;
  @JSONField(name: "ga_prefix")
  late String gaPrefix;
  late List<String> images;
  late int type;
  late int id;
  late List<String> css;

  ZhihuBodyEntity();

  factory ZhihuBodyEntity.fromJson(Map<String, dynamic> json) =>
      $ZhihuBodyEntityFromJson(json);

  Map<String, dynamic> toJson() => $ZhihuBodyEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

import 'dart:convert';

import 'package:item_1/generated/json/base/json_field.dart';
import 'package:item_1/generated/json/zhihu_daily_entity.g.dart';

export 'package:item_1/generated/json/zhihu_daily_entity.g.dart';

/*
json 数据结构
"date": "20230917",

"stories": [
{
"image_hue": "0x425a68",
"title": "小事 · 你都见过哪些不动声色的善良？",
"url": "https://daily.zhihu.com/story/9765527",
"hint": "VOL.1523",
"ga_prefix": "091707",
"images": [
"https://pic1.zhimg.com/v2-a9786ee05cf1e53e430d1967dc23109b.jpg?source=8673f162"
],
"type": 0,
"id": 9765527
},
],

"top_stories": [
{
"image_hue": "0x425a68",
"hint": "作者 / 云难一见",
"url": "https://daily.zhihu.com/story/9765527",
"image": "https://picx.zhimg.com/v2-8ba99db8af3ce2593e8582f4d864402c.jpg?source=8673f162",
"title": "小事 · 你都见过哪些不动声色的善良？",
"ga_prefix": "091707",
"type": 0,
"id": 9765527
},
]
}*/

@JsonSerializable()
class ZhihuDailyEntity {
  late String date;
  late List<ZhihuDailyStories> stories;
  @JSONField(name: "top_stories")
  late List<ZhihuDailyTopStories> topStories;

  ZhihuDailyEntity();

  factory ZhihuDailyEntity.fromJson(Map<String, dynamic> json) =>
      $ZhihuDailyEntityFromJson(json);

  Map<String, dynamic> toJson() => $ZhihuDailyEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZhihuDailyStories {
  @JSONField(name: "image_hue")
  late String imageHue;
  late String title;
  late String url;
  late String hint;
  @JSONField(name: "ga_prefix")
  late String gaPrefix;
  late List<String> images;
  late int type;
  late int id;

  ZhihuDailyStories();

  factory ZhihuDailyStories.fromJson(Map<String, dynamic> json) =>
      $ZhihuDailyStoriesFromJson(json);

  Map<String, dynamic> toJson() => $ZhihuDailyStoriesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ZhihuDailyTopStories {
  @JSONField(name: "image_hue")
  late String imageHue;
  late String hint;
  late String url;
  late String image;
  late String title;
  @JSONField(name: "ga_prefix")
  late String gaPrefix;
  late int type;
  late int id;

  ZhihuDailyTopStories();

  factory ZhihuDailyTopStories.fromJson(Map<String, dynamic> json) =>
      $ZhihuDailyTopStoriesFromJson(json);

  Map<String, dynamic> toJson() => $ZhihuDailyTopStoriesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

import 'package:item_1/generated/json/base/json_convert_content.dart';
import 'package:item_1/http/entity/zhihu_body_entity.dart';

ZhihuBodyEntity $ZhihuBodyEntityFromJson(Map<String, dynamic> json) {
  final ZhihuBodyEntity zhihuBodyEntity = ZhihuBodyEntity();
  final String? body = jsonConvert.convert<String>(json['body']);
  if (body != null) {
    zhihuBodyEntity.body = body;
  }
  final String? imageHue = jsonConvert.convert<String>(json['image_hue']);
  if (imageHue != null) {
    zhihuBodyEntity.imageHue = imageHue;
  }
  final int? publishTime = jsonConvert.convert<int>(json['publish_time']);
  if (publishTime != null) {
    zhihuBodyEntity.publishTime = publishTime;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    zhihuBodyEntity.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    zhihuBodyEntity.url = url;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    zhihuBodyEntity.image = image;
  }
  final String? shareUrl = jsonConvert.convert<String>(json['share_url']);
  if (shareUrl != null) {
    zhihuBodyEntity.shareUrl = shareUrl;
  }
  final List<dynamic>? js =
      (json['js'] as List<dynamic>?)?.map((e) => e).toList();
  if (js != null) {
    zhihuBodyEntity.js = js;
  }
  final int? createTime = jsonConvert.convert<int>(json['create_time']);
  if (createTime != null) {
    zhihuBodyEntity.createTime = createTime;
  }
  final String? gaPrefix = jsonConvert.convert<String>(json['ga_prefix']);
  if (gaPrefix != null) {
    zhihuBodyEntity.gaPrefix = gaPrefix;
  }
  final List<String>? images = (json['images'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (images != null) {
    zhihuBodyEntity.images = images;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    zhihuBodyEntity.type = type;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    zhihuBodyEntity.id = id;
  }
  final List<String>? css = (json['css'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (css != null) {
    zhihuBodyEntity.css = css;
  }
  return zhihuBodyEntity;
}

Map<String, dynamic> $ZhihuBodyEntityToJson(ZhihuBodyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['body'] = entity.body;
  data['image_hue'] = entity.imageHue;
  data['publish_time'] = entity.publishTime;
  data['title'] = entity.title;
  data['url'] = entity.url;
  data['image'] = entity.image;
  data['share_url'] = entity.shareUrl;
  data['js'] = entity.js;
  data['create_time'] = entity.createTime;
  data['ga_prefix'] = entity.gaPrefix;
  data['images'] = entity.images;
  data['type'] = entity.type;
  data['id'] = entity.id;
  data['css'] = entity.css;
  return data;
}

extension ZhihuBodyEntityExtension on ZhihuBodyEntity {
  ZhihuBodyEntity copyWith({
    String? body,
    String? imageHue,
    int? publishTime,
    String? title,
    String? url,
    String? image,
    String? shareUrl,
    List<dynamic>? js,
    int? createTime,
    String? gaPrefix,
    List<String>? images,
    int? type,
    int? id,
    List<String>? css,
  }) {
    return ZhihuBodyEntity()
      ..body = body ?? this.body
      ..imageHue = imageHue ?? this.imageHue
      ..publishTime = publishTime ?? this.publishTime
      ..title = title ?? this.title
      ..url = url ?? this.url
      ..image = image ?? this.image
      ..shareUrl = shareUrl ?? this.shareUrl
      ..js = js ?? this.js
      ..createTime = createTime ?? this.createTime
      ..gaPrefix = gaPrefix ?? this.gaPrefix
      ..images = images ?? this.images
      ..type = type ?? this.type
      ..id = id ?? this.id
      ..css = css ?? this.css;
  }
}

import 'package:item_1/generated/json/base/json_convert_content.dart';
import 'package:item_1/http/entity/zhihu_daily_entity.dart';

ZhihuDailyEntity $ZhihuDailyEntityFromJson(Map<String, dynamic> json) {
  final ZhihuDailyEntity zhihuDailyEntity = ZhihuDailyEntity();
  final String? date = jsonConvert.convert<String>(json['date']);
  if (date != null) {
    zhihuDailyEntity.date = date;
  }
  final List<ZhihuDailyStories>? stories = (json['stories'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZhihuDailyStories>(e) as ZhihuDailyStories)
      .toList();
  if (stories != null) {
    zhihuDailyEntity.stories = stories;
  }
  final List<ZhihuDailyTopStories>? topStories = (json['top_stories']
          as List<dynamic>?)
      ?.map((e) =>
          jsonConvert.convert<ZhihuDailyTopStories>(e) as ZhihuDailyTopStories)
      .toList();
  if (topStories != null) {
    zhihuDailyEntity.topStories = topStories;
  }
  return zhihuDailyEntity;
}

Map<String, dynamic> $ZhihuDailyEntityToJson(ZhihuDailyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['date'] = entity.date;
  data['stories'] = entity.stories.map((v) => v.toJson()).toList();
  data['top_stories'] = entity.topStories.map((v) => v.toJson()).toList();
  return data;
}

extension ZhihuDailyEntityExtension on ZhihuDailyEntity {
  ZhihuDailyEntity copyWith({
    String? date,
    List<ZhihuDailyStories>? stories,
    List<ZhihuDailyTopStories>? topStories,
  }) {
    return ZhihuDailyEntity()
      ..date = date ?? this.date
      ..stories = stories ?? this.stories
      ..topStories = topStories ?? this.topStories;
  }
}

ZhihuDailyStories $ZhihuDailyStoriesFromJson(Map<String, dynamic> json) {
  final ZhihuDailyStories zhihuDailyStories = ZhihuDailyStories();
  final String? imageHue = jsonConvert.convert<String>(json['image_hue']);
  if (imageHue != null) {
    zhihuDailyStories.imageHue = imageHue;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    zhihuDailyStories.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    zhihuDailyStories.url = url;
  }
  final String? hint = jsonConvert.convert<String>(json['hint']);
  if (hint != null) {
    zhihuDailyStories.hint = hint;
  }
  final String? gaPrefix = jsonConvert.convert<String>(json['ga_prefix']);
  if (gaPrefix != null) {
    zhihuDailyStories.gaPrefix = gaPrefix;
  }
  final List<String>? images = (json['images'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (images != null) {
    zhihuDailyStories.images = images;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    zhihuDailyStories.type = type;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    zhihuDailyStories.id = id;
  }
  return zhihuDailyStories;
}

Map<String, dynamic> $ZhihuDailyStoriesToJson(ZhihuDailyStories entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['image_hue'] = entity.imageHue;
  data['title'] = entity.title;
  data['url'] = entity.url;
  data['hint'] = entity.hint;
  data['ga_prefix'] = entity.gaPrefix;
  data['images'] = entity.images;
  data['type'] = entity.type;
  data['id'] = entity.id;
  return data;
}

extension ZhihuDailyStoriesExtension on ZhihuDailyStories {
  ZhihuDailyStories copyWith({
    String? imageHue,
    String? title,
    String? url,
    String? hint,
    String? gaPrefix,
    List<String>? images,
    int? type,
    int? id,
  }) {
    return ZhihuDailyStories()
      ..imageHue = imageHue ?? this.imageHue
      ..title = title ?? this.title
      ..url = url ?? this.url
      ..hint = hint ?? this.hint
      ..gaPrefix = gaPrefix ?? this.gaPrefix
      ..images = images ?? this.images
      ..type = type ?? this.type
      ..id = id ?? this.id;
  }
}

ZhihuDailyTopStories $ZhihuDailyTopStoriesFromJson(Map<String, dynamic> json) {
  final ZhihuDailyTopStories zhihuDailyTopStories = ZhihuDailyTopStories();
  final String? imageHue = jsonConvert.convert<String>(json['image_hue']);
  if (imageHue != null) {
    zhihuDailyTopStories.imageHue = imageHue;
  }
  final String? hint = jsonConvert.convert<String>(json['hint']);
  if (hint != null) {
    zhihuDailyTopStories.hint = hint;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    zhihuDailyTopStories.url = url;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    zhihuDailyTopStories.image = image;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    zhihuDailyTopStories.title = title;
  }
  final String? gaPrefix = jsonConvert.convert<String>(json['ga_prefix']);
  if (gaPrefix != null) {
    zhihuDailyTopStories.gaPrefix = gaPrefix;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    zhihuDailyTopStories.type = type;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    zhihuDailyTopStories.id = id;
  }
  return zhihuDailyTopStories;
}

Map<String, dynamic> $ZhihuDailyTopStoriesToJson(ZhihuDailyTopStories entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['image_hue'] = entity.imageHue;
  data['hint'] = entity.hint;
  data['url'] = entity.url;
  data['image'] = entity.image;
  data['title'] = entity.title;
  data['ga_prefix'] = entity.gaPrefix;
  data['type'] = entity.type;
  data['id'] = entity.id;
  return data;
}

extension ZhihuDailyTopStoriesExtension on ZhihuDailyTopStories {
  ZhihuDailyTopStories copyWith({
    String? imageHue,
    String? hint,
    String? url,
    String? image,
    String? title,
    String? gaPrefix,
    int? type,
    int? id,
  }) {
    return ZhihuDailyTopStories()
      ..imageHue = imageHue ?? this.imageHue
      ..hint = hint ?? this.hint
      ..url = url ?? this.url
      ..image = image ?? this.image
      ..title = title ?? this.title
      ..gaPrefix = gaPrefix ?? this.gaPrefix
      ..type = type ?? this.type
      ..id = id ?? this.id;
  }
}

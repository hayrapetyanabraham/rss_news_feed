// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFeed _$NewsFeedFromJson(Map<String, dynamic> json) {
  return NewsFeed(
    title: json['title'] as String,
    imageUrl: json['imageUrl'] as String,
    guid: json['guid'] as String,
    description: json['description'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$NewsFeedToJson(NewsFeed instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'guid': instance.guid,
      'date': instance.date,
    };

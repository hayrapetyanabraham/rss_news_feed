import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'news_feed.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsFeed {
  final String title;
  final String description;
  final String imageUrl;
  final String guid;
  final String date;
  final String htmlCode;
  final String imageFileName;

  NewsFeed({
    this.title,
    this.imageUrl,
    this.guid,
    this.htmlCode,
    this.description,
    this.date,
    this.imageFileName,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsFeed &&
          runtimeType == other.runtimeType &&
          date == other.date;

  @override
  int get hashCode => date.hashCode;

  factory NewsFeed.fromJson(Map<String, dynamic> json) =>
      _$NewsFeedFromJson(json);

  factory NewsFeed.fromJsonString(String jsonString) =>
      _$NewsFeedFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$NewsFeedToJson(this);

  NewsFeed clone() => NewsFeed.fromJson(toJson());
}

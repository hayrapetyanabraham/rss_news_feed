import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:dart_rss/dart_rss.dart';

class NewsFeedRepository {
  final Dio dio = GetIt.I<Dio>();

  Future<List<RssItem>> getNewsFeed() async {
    final res = await dio.get('/section/front-page/feed');
    var rssFeeds = new RssFeed.parse(res.data);
    return rssFeeds.items;
  }

  Future<String> getHtml(String url) async {
    final res = await dio.get(url);
    return res.data;
  }
}

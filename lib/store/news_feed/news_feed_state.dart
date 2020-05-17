import 'dart:async';

import 'package:dart_rss/domain/rss_item.dart';
import 'package:mobx/mobx.dart';
import 'package:newsfeed/helpers/data_helper.dart';
import 'package:newsfeed/models/news_feed/news_feed.dart';
import 'package:newsfeed/repositories/news_feed/news_feed_repository.dart';
import 'package:newsfeed/store/loading/loading_state.dart';

part 'news_feed_state.g.dart';

class NewsFeedState = _NewsFeedState with _$NewsFeedState;

abstract class _NewsFeedState with Store {
  final newsFeedRepository = NewsFeedRepository();
  final loadingState = LoadingState();
  final dataHelper = DataHelper();

  @observable
  double countMb = 0;

  @observable
  List<RssItem> rssItemList = [];

  @observable
  List<NewsFeed> storedNewsFeedList = [];

  @action
  Future<void> getNewsFeeds() async {
    if (rssItemList.isEmpty) {
      loadingState.startLoading();
    }
    rssItemList = await newsFeedRepository.getNewsFeed();
    if (loadingState.loading) {
      loadingState.stopLoading();
    }
  }

  @action
  Future<void> storeNewsFeed(RssItem rssItem) async {
    final newsFeed = NewsFeed(
        guid: rssItem.guid,
        title: rssItem.title,
        imageUrl: rssItem.enclosure.url,
        description: rssItem.description,
        date: rssItem.pubDate);
    await dataHelper.add(newsFeed: newsFeed);
  }

  @action
  Future<void> deleteNewsFeed({NewsFeed newsFeed}) async {
    await dataHelper.delete(newsFeed: newsFeed);
    getStoredItemList();
  }

  @action
  Future<void> getStoredItemList() async {
    storedNewsFeedList = await dataHelper.getAllNewsFeed();
  }
}

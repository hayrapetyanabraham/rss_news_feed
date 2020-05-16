import 'dart:async';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:mobx/mobx.dart';
import 'package:newsfeed/repositories/news_feed/news_feed_repository.dart';
import 'package:newsfeed/store/loading/loading_state.dart';

part 'news_feed_state.g.dart';

class NewsFeedState = _NewsFeedState with _$NewsFeedState;

abstract class _NewsFeedState with Store {
  final newsFeedRepository = NewsFeedRepository();
  final loadingState = LoadingState();

  @observable
  List<RssItem> rssItemList = [];

  @action
  Future<void> getNewsFeeds() async {
    loadingState.startLoading();
    rssItemList = await newsFeedRepository.getNewsFeed();
    loadingState.stopLoading();
  }
}

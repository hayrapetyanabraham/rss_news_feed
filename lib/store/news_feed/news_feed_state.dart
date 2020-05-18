import 'dart:async';
import 'dart:io';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:newsfeed/helpers/data_helper.dart';
import 'package:newsfeed/helpers/preferences_helper.dart';
import 'package:newsfeed/models/news_feed/news_feed.dart';
import 'package:newsfeed/repositories/news_feed/news_feed_repository.dart';
import 'package:newsfeed/store/loading/loading_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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

  Directory appDocumentDir;

  @observable
  bool hasUnreadNewsFeeds = false;

  @observable
  String lastNewsFeedDate;

  @action
  Future<void> getNewsFeeds() async {
    if (rssItemList.isEmpty) {
      loadingState.startLoading();
    }
    try {
      List<RssItem> rssItems = await newsFeedRepository.getNewsFeed();
      rssItemList = rssItems;
    } on DioError catch (e) {
      throw e.response.data;
    } finally {
      loadingState.stopLoading();
    }
  }

  Future<void> initLastNewsDate() async {
    lastNewsFeedDate = await StorageHelper.getLastNewsDate();
  }

  @action
  Future<void> storeNewsFeed(RssItem rssItem) async {
    final newsFeed = NewsFeed(
        guid: rssItem.guid,
        title: rssItem.title,
        imageUrl: rssItem.enclosure.url,
        description: rssItem.description,
        imageFileName: Uuid().v1(),
        date: rssItem.pubDate);
    await dataHelper.add(newsFeed: newsFeed);
  }

  @action
  File storeImage(String imageName) {
    return dataHelper.fileFromDocsDir(imageName, appDocumentDir);
  }

  @action
  Future<void> initAppDirectory() async {
    appDocumentDir = await getApplicationDocumentsDirectory();
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

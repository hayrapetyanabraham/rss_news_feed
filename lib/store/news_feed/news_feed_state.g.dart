// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsFeedState on _NewsFeedState, Store {
  final _$countMbAtom = Atom(name: '_NewsFeedState.countMb');

  @override
  double get countMb {
    _$countMbAtom.reportRead();
    return super.countMb;
  }

  @override
  set countMb(double value) {
    _$countMbAtom.reportWrite(value, super.countMb, () {
      super.countMb = value;
    });
  }

  final _$rssItemListAtom = Atom(name: '_NewsFeedState.rssItemList');

  @override
  List<RssItem> get rssItemList {
    _$rssItemListAtom.reportRead();
    return super.rssItemList;
  }

  @override
  set rssItemList(List<RssItem> value) {
    _$rssItemListAtom.reportWrite(value, super.rssItemList, () {
      super.rssItemList = value;
    });
  }

  final _$storedNewsFeedListAtom =
      Atom(name: '_NewsFeedState.storedNewsFeedList');

  @override
  List<NewsFeed> get storedNewsFeedList {
    _$storedNewsFeedListAtom.reportRead();
    return super.storedNewsFeedList;
  }

  @override
  set storedNewsFeedList(List<NewsFeed> value) {
    _$storedNewsFeedListAtom.reportWrite(value, super.storedNewsFeedList, () {
      super.storedNewsFeedList = value;
    });
  }

  final _$getNewsFeedsAsyncAction = AsyncAction('_NewsFeedState.getNewsFeeds');

  @override
  Future<void> getNewsFeeds() {
    return _$getNewsFeedsAsyncAction.run(() => super.getNewsFeeds());
  }

  final _$storeNewsFeedAsyncAction =
      AsyncAction('_NewsFeedState.storeNewsFeed');

  @override
  Future<void> storeNewsFeed(RssItem rssItem) {
    return _$storeNewsFeedAsyncAction.run(() => super.storeNewsFeed(rssItem));
  }

  final _$deleteNewsFeedAsyncAction =
      AsyncAction('_NewsFeedState.deleteNewsFeed');

  @override
  Future<void> deleteNewsFeed({NewsFeed newsFeed}) {
    return _$deleteNewsFeedAsyncAction
        .run(() => super.deleteNewsFeed(newsFeed: newsFeed));
  }

  final _$getStoredItemListAsyncAction =
      AsyncAction('_NewsFeedState.getStoredItemList');

  @override
  Future<void> getStoredItemList() {
    return _$getStoredItemListAsyncAction.run(() => super.getStoredItemList());
  }

  @override
  String toString() {
    return '''
countMb: ${countMb},
rssItemList: ${rssItemList},
storedNewsFeedList: ${storedNewsFeedList}
    ''';
  }
}

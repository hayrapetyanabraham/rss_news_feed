// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsFeedState on _NewsFeedState, Store {
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

  final _$getNewsFeedsAsyncAction = AsyncAction('_NewsFeedState.getNewsFeeds');

  @override
  Future<void> getNewsFeeds() {
    return _$getNewsFeedsAsyncAction.run(() => super.getNewsFeeds());
  }

  @override
  String toString() {
    return '''
rssItemList: ${rssItemList}
    ''';
  }
}

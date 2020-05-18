import 'package:auto_route/auto_route.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/mixins/scaffold_mixin.dart';
import 'package:newsfeed/navigator/router.gr.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:newsfeed/widget/news_feed_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> with ScaffoldMixin {
  final newsFeedState = NewsFeedState();
  final RefreshController _newsFeedsRefreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getNewsFeeds();
    initDate();
  }

  Future<void> getNewsFeeds() async {
    await newsFeedState.getNewsFeeds();
  }

  Future<void> initDate() async {
    await newsFeedState.initLastNewsDate();
  }

  @override
  void dispose() {
    _newsFeedsRefreshController.dispose();
    super.dispose();
  }

  Future<void> _onNewsFeedsRefresh() async {
    getNewsFeeds();
    _newsFeedsRefreshController.refreshCompleted();
  }

  void showFullVersionNews(RssItem rssItem) {
    ExtendedNavigator.rootNavigator.pushNamed(
      Routes.readNewsPage,
      arguments: ReadNewsPageArguments(newsUrl: rssItem.guid),
    );
  }

  Future<void> onArchiveClick(RssItem rssItem) async {
    await newsFeedState.storeNewsFeed(rssItem);
    showSnackBar(scaffoldKey, text: 'Archived', color: archivedBlue);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return newsFeedState.loadingState.loading
          ? Container(
              alignment: Alignment.center,
              height: 48,
              width: 48,
              child: const CircularProgressIndicator(),
            )
          : Scaffold(
              key: scaffoldKey,
              backgroundColor: primaryColor,
              body: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 30),
                  child: SmartRefresher(
                      enablePullDown: true,
                      header: WaterDropHeader(),
                      controller: _newsFeedsRefreshController,
                      onRefresh: _onNewsFeedsRefresh,
                      child: newsFeedState.rssItemList.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: newsFeedState.rssItemList.length,
                              itemBuilder: (context, index) {
                                final rssItem =
                                    newsFeedState.rssItemList[index];
                                return ListTile(
                                  onTap: () {
                                    showFullVersionNews(
                                        newsFeedState.rssItemList[index]);
                                  },
                                  title: NewsFeedItem(
                                    onActionClick: () {
                                      onArchiveClick(rssItem);
                                    },
                                    imageFileName: null,
                                    title: rssItem.title,
                                    imageUrl: rssItem.enclosure.url,
                                    description: rssItem.description,
                                    date: rssItem.pubDate,
                                    isArchive: false,
                                  ),
                                );
                              })
                          : Center(
                              child: Text(
                                  'please check your devices network connection',
                                  style: const TextStyle(
                                      color: charcoalGreyColor, fontSize: 12)),
                            ))),
            );
    });
  }
}

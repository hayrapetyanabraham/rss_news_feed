import 'package:auto_route/auto_route.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/navigator/router.gr.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:newsfeed/widget/news_feed_item.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final newsFeedState = NewsFeedState();

  @override
  void initState() {
    super.initState();
    newsFeedState.getNewsFeeds();
  }

  void showFullVersionNews(RssItem rssItem) {
    ExtendedNavigator.rootNavigator.pushNamed(
      Routes.readNewsPage,
      arguments: ReadNewsPageArguments(newsUrl: rssItem.guid),
    );
  }

  void onArchiveClick(RssItem rssItem) {
    newsFeedState.storeNewsFeed(rssItem);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return newsFeedState.loadingState.loading
          ? Container(
              alignment: Alignment.center,
              height: 48,
              width: 48,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(navyColor),
              ),
            )
          : Scaffold(
              backgroundColor: primaryColor,
              body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: newsFeedState.rssItemList.length,
                  itemBuilder: (context, index) {
                    final rssItem = newsFeedState.rssItemList[index];
                    return ListTile(
                      onTap: () {
                        showFullVersionNews(newsFeedState.rssItemList[index]);
                      },
                      title: NewsFeedItem(
                        onArchiveClick: () {
                          onArchiveClick(rssItem);
                        },
                        title: rssItem.title,
                        imageUrl: rssItem.enclosure.url,
                        description: rssItem.description,
                        date: rssItem.pubDate,
                        isArchive: false,
                      ),
                    );
                  }),
            );
    });
  }
}

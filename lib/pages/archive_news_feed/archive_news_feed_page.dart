import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/models/news_feed/news_feed.dart';
import 'package:newsfeed/navigator/router.gr.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:newsfeed/widget/news_feed_item.dart';

class ArchiveNewsFeedPage extends StatefulWidget {
  @override
  _ArchiveNewsFeedPageState createState() => _ArchiveNewsFeedPageState();
}

class _ArchiveNewsFeedPageState extends State<ArchiveNewsFeedPage> {
  final newsFeedState = NewsFeedState();

  @override
  void initState() {
    super.initState();
    newsFeedState.getStoredItemList();
  }

  void showFullVersionNews(NewsFeed newsFeed) {
    ExtendedNavigator.rootNavigator.pushNamed(
      Routes.readNewsPage,
      arguments: ReadNewsPageArguments(newsUrl: newsFeed.guid),
    );
  }

  Future<void> onArchiveClick(NewsFeed newsFeed) async {
    await newsFeedState.deleteNewsFeed(newsFeed: newsFeed);
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
                  itemCount: newsFeedState.storedNewsFeedList.length,
                  itemBuilder: (context, index) {
                    final newsFeed = newsFeedState.storedNewsFeedList[index];
                    return ListTile(
                      onTap: () {
                        showFullVersionNews(newsFeedState.storedNewsFeedList[index]);
                      },
                      title: NewsFeedItem(
                        onArchiveClick: () {
                          onArchiveClick(newsFeed);
                        },
                        title: newsFeed.title,
                        imageUrl: newsFeed.imageUrl,
                        description: newsFeed.description,
                        date: newsFeed.date,
                        isArchive: true,
                      ),
                    );
                  }),
            );
    });
  }
}

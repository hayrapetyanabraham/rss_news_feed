import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/mixins/scaffold_mixin.dart';
import 'package:newsfeed/models/news_feed/news_feed.dart';
import 'package:newsfeed/navigator/router.gr.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:newsfeed/widget/news_feed_item.dart';

class ArchiveNewsFeedPage extends StatefulWidget {
  @override
  _ArchiveNewsFeedPageState createState() => _ArchiveNewsFeedPageState();
}

class _ArchiveNewsFeedPageState extends State<ArchiveNewsFeedPage>
    with ScaffoldMixin {
  final newsFeedState = NewsFeedState();

  @override
  void initState() {
    super.initState();
    newsFeedState.initAppDirectory();
    newsFeedState.getStoredItemList();
  }

  void showFullVersionNews(NewsFeed newsFeed) {
    ExtendedNavigator.rootNavigator.pushNamed(
      Routes.readNewsPage,
      arguments: ReadNewsPageArguments(
          newsUrl: newsFeed.guid, htmlCode: newsFeed.htmlCode),
    );
  }

  Future<void> onDeleteClick(NewsFeed newsFeed) async {
    await newsFeedState.deleteNewsFeed(newsFeed: newsFeed);
    showSnackBar(scaffoldKey, text: 'Deleted', color: deletedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return newsFeedState.loadingState.loading
          ? Container()
          : Scaffold(
              key: scaffoldKey,
              backgroundColor: primaryColor,
              body: newsFeedState.storedNewsFeedList.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: newsFeedState.storedNewsFeedList.length,
                          itemBuilder: (context, index) {
                            final newsFeed =
                                newsFeedState.storedNewsFeedList[index];
                            return ListTile(
                              onTap: () {
                                showFullVersionNews(
                                    newsFeedState.storedNewsFeedList[index]);
                              },
                              title: NewsFeedItem(
                                onActionClick: () {
                                  onDeleteClick(newsFeed);
                                },
                                imageFileName: newsFeed.imageFileName,
                                title: newsFeed.title,
                                imageUrl: newsFeed.imageUrl,
                                description: newsFeed.description,
                                date: newsFeed.date,
                                isArchive: true,
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: Text('The archived news feeds are not existing'),
                    ));
    });
  }
}

import 'package:file_cache/file_cache.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/helpers/date_helper.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';
import 'package:newsfeed/widget/shadow_container.dart';

class NewsFeedItem extends StatelessWidget {
  final Function onActionClick;
  final String title;
  final String imageUrl;
  final String description;
  final String date;
  final String imageFileName;
  final bool isArchive;
  final NewsFeedState newsFeedState;

  const NewsFeedItem(
      {this.onActionClick,
      this.title,
      this.imageUrl,
      this.description,
      this.imageFileName,
      this.date,
      this.newsFeedState,
      this.isArchive});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      blurRadius: 30,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 35),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      shadowColor: newsFeedState?.lastNewsFeedDate != null
          ? (isAfterDate(newsFeedState.lastNewsFeedDate, date)
              ? const Color.fromRGBO(144, 238, 144, 0.25)
              : const Color.fromRGBO(188, 201, 215, 0.25))
          : const Color.fromRGBO(188, 201, 215, 0.25),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: navyColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image(
                fit: BoxFit.cover,
                image: new FileCacheImage(imageUrl),
              ),
            ),
            Text(
              description,
              style: const TextStyle(color: charcoalGreyColor, fontSize: 16),
            ),
            InkWell(
              onTap: onActionClick,
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(convertDateFrom(date),
                            style: const TextStyle(
                                color: navyColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
                    if (isArchive) ...[
                      Text('Remove ',
                          style: const TextStyle(
                              color: charcoalGreyColor, fontSize: 14)),
                      Icon(Icons.delete, size: 30, color: iconsMainColor)
                    ] else ...[
                      Text('store ',
                          style: const TextStyle(
                              color: charcoalGreyColor, fontSize: 14)),
                      Icon(Icons.archive, size: 30, color: iconsMainColor)
                    ]
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/helpers/date_helper.dart';
import 'package:newsfeed/widget/shadow_container.dart';
import 'package:intl/intl.dart';

class NewsFeedItem extends StatelessWidget {
  final RssItem rssItem;

  const NewsFeedItem({this.rssItem});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      blurRadius: 30,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      shadowColor: const Color.fromRGBO(188, 201, 215, 0.25),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              rssItem.title,
              style: const TextStyle(
                  color: navyColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(rssItem.enclosure.url),
            ),
            Text(
              rssItem.description,
              style: const TextStyle(color: charcoalGreyColor, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    convertDateFrom(rssItem.pubDate),
                    style: const TextStyle(color: navyColor, fontSize: 12),
                  ),
                ),
                Align(
                  heightFactor: 0.1,
                  widthFactor: 0.6,
                  child: FlatButton(
                    onPressed: () {},
                    child: Icon(Icons.archive, size: 30, color: iconsMainColor),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

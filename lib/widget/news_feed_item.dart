import 'package:flutter/material.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/helpers/date_helper.dart';
import 'package:newsfeed/widget/shadow_container.dart';

class NewsFeedItem extends StatelessWidget {
  final Function onArchiveClick;
  final String title;
  final String imageUrl;
  final String description;
  final String date;
  final bool isArchive;

  const NewsFeedItem(
      {this.onArchiveClick,
      this.title,
      this.imageUrl,
      this.description,
      this.date,
      this.isArchive});

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
              title,
              style: const TextStyle(
                  color: navyColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(imageUrl),
            ),
            Text(
              description,
              style: const TextStyle(color: charcoalGreyColor, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    convertDateFrom(date),
                    style: const TextStyle(color: navyColor, fontSize: 12),
                  ),
                ),
                Align(
                  heightFactor: 0.1,
                  widthFactor: 0.6,
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          onArchiveClick();
                        },
                        child: isArchive
                            ? Icon(Icons.delete, size: 30, color: iconsMainColor)
                            : Icon(Icons.archive,
                            size: 30, color: iconsMainColor)),
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

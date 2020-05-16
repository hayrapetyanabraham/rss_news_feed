// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:newsfeed/pages/dashboard/dashboard_page.dart';
import 'package:newsfeed/pages/news_feed/news_feed_page.dart';
import 'package:newsfeed/pages/read_news/read_news_page.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:newsfeed/pages/archive_news_feed/archive_news_feed_page.dart';

abstract class Routes {
  static const dashboardPage = '/';
  static const newsFeedPage = '/news-feed-page';
  static const readNewsPage = '/read-news-page';
  static const archiveNewsFeedPage = '/archive-news-feed-page';
  static const all = {
    dashboardPage,
    newsFeedPage,
    readNewsPage,
    archiveNewsFeedPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.dashboardPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DashboardPage(),
          settings: settings,
        );
      case Routes.newsFeedPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => NewsFeedPage(),
          settings: settings,
        );
      case Routes.readNewsPage:
        if (hasInvalidArgs<ReadNewsPageArguments>(args)) {
          return misTypedArgsRoute<ReadNewsPageArguments>(args);
        }
        final typedArgs =
            args as ReadNewsPageArguments ?? ReadNewsPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ReadNewsPage(rssItem: typedArgs.rssItem),
          settings: settings,
        );
      case Routes.archiveNewsFeedPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ArchiveNewsFeedPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//ReadNewsPage arguments holder class
class ReadNewsPageArguments {
  final RssItem rssItem;
  ReadNewsPageArguments({this.rssItem});
}

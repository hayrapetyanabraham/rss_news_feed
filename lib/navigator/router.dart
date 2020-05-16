import 'package:auto_route/auto_route_annotations.dart';
import 'package:newsfeed/pages/archive_news_feed/archive_news_feed_page.dart';
import 'package:newsfeed/pages/dashboard/dashboard_page.dart';
import 'package:newsfeed/pages/news_feed/news_feed_page.dart';
import 'package:newsfeed/pages/read_news/read_news_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  DashboardPage dashboardPage;
  NewsFeedPage newsFeedPage;
  ReadNewsPage readNewsPage;
  ArchiveNewsFeedPage archiveNewsFeedPage;
}

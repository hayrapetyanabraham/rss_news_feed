import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/pages/archive_news_feed/archive_news_feed_page.dart';
import 'package:newsfeed/pages/news_feed/news_feed_page.dart';
import 'package:newsfeed/pages/settings/settings_page.dart';
import 'package:newsfeed/store/news_feed/news_feed_state.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  final newsFeedState = NewsFeedState();
  TabController _tabController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    tabControllerInitializer();
    _tabController.addListener(() {
      setState(() {
        _page = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void tabControllerInitializer() {
    _tabController = TabController(
      vsync: this,
      initialIndex: _page,
      length: 3,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _page = _tabController.previousIndex;
      } else {
        setState(() {
          _page = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        TabBarView(
          controller: _tabController,
          children: [
            Tab(child: NewsFeedPage()),
            Tab(child: ArchiveNewsFeedPage()),
            Tab(child: SettingsPage()),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _page,
            height: MediaQuery.of(context).viewInsets.bottom == 0 ? 56 : 0,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            items: <Widget>[
              Icon(Icons.home, size: 30, color: iconsMainColor),
              Icon(Icons.archive, size: 30, color: iconsMainColor),
              Icon(Icons.settings, size: 30, color: iconsMainColor),
            ],
            color: Colors.white,
            onTap: (index) {
              _tabController.animateTo(index);
            },
          ),
        ),
      ],
    ));
  }
}

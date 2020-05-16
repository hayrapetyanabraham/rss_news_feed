import 'dart:async';

import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadNewsPage extends StatefulWidget {
  final RssItem rssItem;

  const ReadNewsPage({this.rssItem});

  @override
  _ReadNewsPageState createState() => _ReadNewsPageState();
}

class _ReadNewsPageState extends State<ReadNewsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Observer(builder: (_) {
        return WebView(
          initialUrl: widget.rssItem.guid,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewCreate) {
            _controller.complete(webViewCreate);
          },
        );
      }),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsfeed/store/loading/loading_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadNewsPage extends StatefulWidget {
  final String newsUrl;
  final String htmlCode;

  const ReadNewsPage({this.newsUrl, this.htmlCode});

  @override
  _ReadNewsPageState createState() => _ReadNewsPageState();
}

class _ReadNewsPageState extends State<ReadNewsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController _controllerOffline;
  bool hasInternetConnection = false;
  final loading = LoadingState();

  @override
  void initState() {
    super.initState();
    checkInternetState();
  }

  Future<void> checkInternetState() async {
    loading.startLoading();
    hasInternetConnection = await DataConnectionChecker().hasConnection;
    loading.stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return loading.loading
          ? Container(
              alignment: Alignment.center,
              height: 48,
              width: 48,
              child: const CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(),
              body: hasInternetConnection
                  ? WebView(
                      initialUrl: widget.newsUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (webViewCreate) {
                        _controller.complete(webViewCreate);
                      },
                    )
                  : WebView(
                      initialUrl: 'about:blank',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controllerOffline = webViewController;
                        _loadHtml();
                      },
                    ),
            );
    });
  }

  _loadHtml() async {
    String fileText = widget.htmlCode;
    _controllerOffline.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

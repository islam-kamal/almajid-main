import 'package:almajidoud/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as flutter;


class WebView extends StatefulWidget {
  final String url;
  final String title;
  final AppBar appBar;

  const WebView({this.title,  this.url, this.appBar});


  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = true;
  String html = '';
  flutter.WebViewController _controller;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.appBar ??
          AppBar(
            backgroundColor: mainColor,
            elevation: 0.0,
            title: Text(
              widget.title ?? '',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  var value = await _controller.canGoBack();
                  if (value) {
                    await _controller.goBack();
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
          ),
      body: Builder(builder: (BuildContext context) {
        return flutter.WebView(
          initialUrl: widget.url,
          javascriptMode: flutter.JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) {
            _controller = webViewController;
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}

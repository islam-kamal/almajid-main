import 'package:almajidoud/utils/colors.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart' as flutter;


class WebView extends StatefulWidget {
  final String? url;
  final String? title;
  final AppBar? appBar;

  const WebView({this.title,  this.url, this.appBar});


  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = true;
  String html = '';
  flutter.WebViewController? _controller;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.appBar ??
          AppBar(
            backgroundColor: whiteColor,
            elevation: 0.0,
            title: Text(
              translator.translate(widget.title!) ,
              style: TextStyle(color: mainColor,fontWeight: FontWeight.normal),
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: mainColor,),
                onPressed: () async {
                  var value = await _controller!.canGoBack();
                  if (value) {
                    await _controller!.goBack();
                  } else {
                    Navigator.of(context).pop();
                  }
                }),

          ),
      body: Stack(
        children: [
          Builder(builder: (BuildContext context) {
            return flutter.WebView(
              initialUrl: widget.url,
              javascriptMode: flutter.JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                _controller = webViewController;
              },
              onPageFinished: (finish){
                setState(() {
                  isLoading = false;
                });
              },
              gestureNavigationEnabled: true,
            );
          }),
          isLoading ? Center(
              child: SpinKitFadingCube(
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ))
              : Stack(),
        ],
      )


    );
  }
}

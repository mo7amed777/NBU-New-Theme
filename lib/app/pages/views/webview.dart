import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String _url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();

  const WebViewScreen({
    required String url,
  }) : _url = url;
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _tag = 'WebViewScreen';

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  int _stackToView = 1;

  @override
  void dispose() {
    controller.clearCache();
    CookieManager().clearCookies();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildOnlineView()),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  _buildOnlineView() {
    return IndexedStack(
      index: _stackToView,
      children: [
        WebView(
          debuggingEnabled: true,
          onWebViewCreated: (v) {
            controller = v;
            return;
          },
          initialUrl: widget._url,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _stackToView = 0;
            });
          },
          onProgress: (v) {
            setState(() {
              _stackToView = 1;
            });
          },
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        if (_stackToView == 1)
          Center(
              child: CircularProgressIndicator(
            color: colorPrimary,
          ))
      ],
    );
  }
}

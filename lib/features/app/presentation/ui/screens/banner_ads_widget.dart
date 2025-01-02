import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late final WebViewController _controller;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller cho WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isAdLoaded = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Nếu bạn muốn kiểm soát URL nào được phép tải
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://sites.google.com/view/vn-sign-in?'));
    //..loadRequest(Uri.parse('https://gg-ads-ten.vercel.app/'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
/*          if (!_isAdLoaded)
            Center(
              child: CupertinoActivityIndicator(),
            ),*/
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedirectWebView extends StatefulWidget {
  final String title;
  final String url;

  const RedirectWebView({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  _RedirectWebViewState createState() => _RedirectWebViewState();
}

class _RedirectWebViewState extends State<RedirectWebView> {
  late final WebViewController controller;
  bool isLoading = true; // Trạng thái loading ban đầu

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Nếu cần, bạn có thể cập nhật trạng thái loading dựa trên progress.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true; // Hiển thị loading khi bắt đầu tải trang
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false; // Ẩn loading khi tải xong trang
            });
          },
          onHttpError: (HttpResponseError error) {
            // Xử lý lỗi HTTP nếu cần
          },
          onWebResourceError: (WebResourceError error) {
            // Xử lý lỗi tài nguyên nếu cần
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Center(
              child: Container(
                color: Colors.black.withOpacity(0),
                child: Transform.scale(
                  scale: 1.5,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    _webViewController = WebViewController();
      _webViewController.setBackgroundColor(const Color(0x00000000));

     _webViewController.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https") ||
                request.url.startsWith("http")) {
              return NavigationDecision.navigate;
            }
            launch(request.url);
            return NavigationDecision.prevent;
          },
        ),
      ).then((value) async => await _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted)).then((value) async => await _webViewController.loadRequest(Uri.parse(widget.url)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body: SafeArea(
        body: Stack(
          children: [
            SafeArea(
              child: Container(
                color: Colors.black,
                child: WebViewWidget(controller: _webViewController,
                        ),
              ),
            ),

          isLoading ? Center( child: CircularProgressIndicator(color: Colors.white,),)
                    : Stack(),

        ]),
      // ),
    );
  }
}
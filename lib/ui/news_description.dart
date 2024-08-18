import 'package:flutter/material.dart';
import 'package:news_application/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late WebViewController webController;

  @override
  void initState() {
    super.initState();
    // Initializing the WebViewController
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // Enable JavaScript mode for testing
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: WebViewWidget(controller: webController),
    );
  }
}

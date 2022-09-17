import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SGPACalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SGPACalculatorState();
  }
}

class _SGPACalculatorState extends State<SGPACalculator> {
  //
  WebViewController? _webViewController;
  String filePath = 'assets/webpages/sgpa.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SGPA Calculator')),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController?.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

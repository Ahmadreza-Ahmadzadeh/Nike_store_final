import 'package:flutter/material.dart';
import 'package:nike_store/screen/receipt/reciept.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatelessWidget {
  final String bankGetUrl;

  const PaymentWebViewPage({super.key, required this.bankGetUrl});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: bankGetUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        debugPrint("url : $url");
        final uri = Uri.parse(url);
        final orderId = int.parse(uri.queryParameters["order_id"]!);
        if (uri.pathSegments.contains("appCheckout") &&
            uri.host == "expertdevelopers.ir") {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReceiptScreen(orderId: orderId),
          ));
        }
      },
    );
  }
}

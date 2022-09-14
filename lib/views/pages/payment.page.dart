import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/dialogs/custom_confirm.dialog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return customConfirmDialog(
              context: context,
              title: 'Keluar Sekarang ?',
              contentText: 'Harap menyelesaikan pembayaran kamu sebelum keluar',
              onConfirm: () {
                context.pop();
                context.pop();
                return true;
              },
            );
          },
        );
        return false;
      },
      child: BasePage(
        withAppBar: true,
        customAppBar: true,
        activeContext: context,
        onBackPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return customConfirmDialog(
                context: context,
                title: 'Keluar Sekarang ?',
                contentText: 'Harap menyelesaikan pembayaran kamu sebelum keluar',
                onConfirm: () {
                  context.pop();
                  context.pop();
                },
              );
            },
          );
        },
        backgroundColorAppBar: AppColor.royalOrange,
        title: "Proses Pembayaran",
        body: SafeArea(
          child: WebView(
            onPageStarted: (url) {
              if (kDebugMode) {
                print(url);
              }
            },
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) {
              // here i will run the javascript code to perform something like scrapping and automation
            },
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
          ),
        ),
      ),
    );
  }
}

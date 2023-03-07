import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: library_prefixes
import 'package:project/values/constants.dart' as Constants;

import '../provider_bloc/cart_items/cart_bloc.dart';

// ignore: must_be_immutable
class WebView extends StatelessWidget {
  WebView({super.key});
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    print('hey');
    print(context.select(((CartBloc bloc) => bloc.state.url)));
    //   String url = context.select((CartBloc bloc) => bloc.state.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
          Uri.parse(context.select(((CartBloc bloc) => bloc.state.url))));
    //context.select(((CartBloc bloc) => bloc.state.url))
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: WebViewWidget(controller: _controller),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Вы хотите выйти?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Нет'),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Да'),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}

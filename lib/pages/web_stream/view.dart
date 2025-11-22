import 'package:flutter/material.dart';
import 'package:live_cric/pages/web_stream/controller.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebStreamView extends StatelessWidget {
  const WebStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<WebStreamController, bool>(
        selector: (p0, p1) => p1.loading,
        builder: (context, loading, child) => loading
            ? Common.loader()
            : WebViewWidget(
                controller: Provider.of<WebStreamController>(
                  context,
                  listen: false,
                ).controller!,
              ).paddingBottom(MediaQuery.of(context).padding.bottom),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyController extends ChangeNotifier {
  bool _mounted = false;
  bool _checked = false;
  bool _loading = true;
  WebViewController? controller;

  bool get loading => _loading;
  bool get checked => _checked;

  PrivacyController(BuildContext context) {
    _mounted = true;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _loading = false;
            notify();
          },
          onWebResourceError: (WebResourceError error) {
            _loading = false;
            notify();
            Common.showSnackbar(context, nb.errorMessage);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(RemoteConfigs.privacyPolicyRc));
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void updateCheck() {
    if (_loading) return;
    _checked = !_checked;
    notify();
  }

  void onSubmit(BuildContext context) {
    if (!_checked) {
      Common.showSnackbar(context, "Please accept privacy policy terms.");
      return;
    }
    nb.setValue(privacyConsentKey, true);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.selectCountryRt,
      (route) => false,
    );
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}

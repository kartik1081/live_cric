import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebStreamController extends ChangeNotifier {
  late final String url;
  bool _mounted = false;
  bool _loading = true;
  WebViewController? controller;
  int _reloadAttempts = 0;
  static const int _maxReloadAttempts = 1;

  bool get loading => _loading;

  WebStreamController(BuildContext context, {required this.url}) {
    _mounted = true;

    controller = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "FlutterChannel",
        onMessageReceived: (message) async {
          if (message.message == 'enterFullscreen') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          } else if (message.message == 'exitFullscreen') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            await controller?.runJavaScript(_robustInjectionScript);
            _loading = false;
            notify();
          },
          onWebResourceError: (WebResourceError error) {
            nb.log("Web error: ${error.errorCode}");

            // If page got hijacked or failed
            if ((error.errorCode == -202 || error.errorCode == -1) &&
                _reloadAttempts < _maxReloadAttempts) {
              _reloadAttempts++;
              controller?.loadRequest(Uri.parse(url));
            }

            _loading = false;
            notify();
          },
          onNavigationRequest: (NavigationRequest request) {
            launchUrl(
              Uri.parse(
                RemoteConfigs.affLinksRc.isEmpty
                    ? ""
                    : RemoteConfigs.affLinksRc[Random().nextInt(
                        RemoteConfigs.affLinksRc.length,
                      )],
              ),
              mode: LaunchMode.inAppBrowserView,
            );
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  String get _robustInjectionScript => """
  (function() {
      console.log('Robust Fullscreen Listener Injected');
      
      // Attach the listener directly to the document to catch any element entering fullscreen
      document.addEventListener('fullscreenchange', onFullscreenChange);
      document.addEventListener('webkitfullscreenchange', onFullscreenChange);
      document.addEventListener('mozfullscreenchange', onFullscreenChange);
      
      // Also listen for iOS-specific events, though often handled by webkitfullscreenchange
      document.addEventListener('webkitbeginfullscreen', () => {
          FlutterChannel.postMessage('enterFullscreen');
      });
      document.addEventListener('webkitendfullscreen', () => {
          FlutterChannel.postMessage('exitFullscreen');
      });

      function onFullscreenChange() {
          // Check if any element is currently occupying the fullscreen window
          // document.fullscreenElement is the standard check
          const isFullscreen = document.fullscreenElement || document.webkitFullscreenElement || document.mozFullScreenElement;
          
          if (isFullscreen) {
              FlutterChannel.postMessage('enterFullscreen');
          } else {
              FlutterChannel.postMessage('exitFullscreen');
          }
      }
      
      // Attempt to attach listeners directly to all video elements found (as a fallback)
      const videos = document.querySelectorAll('video');
      videos.forEach(video => {
          // You can also try attaching to the click event on the video or controls
          video.addEventListener('play', () => {
              // Sometimes playing a video auto-enters fullscreen on mobile, so check state
              if (video.webkitDisplayingFullscreen) {
                  FlutterChannel.postMessage('enterFullscreen');
              }
          });
      });
  })();
""";

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Common.tapListener();
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}

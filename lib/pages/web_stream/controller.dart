import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:webview_flutter/webview_flutter.dart';

class WebStreamController extends ChangeNotifier {
  late final String url;

  bool _mounted = false;
  bool _loading = true;
  int _lastStreamingSeconds = 300;
  WebViewController? controller;
  Timer? timer;

  bool get loading => _loading;

  WebStreamController(BuildContext context, {required this.url}) {
    _mounted = true;
    _lastStreamingSeconds = nb.getIntAsync(
      cricketStreamingSecondKey,
      defaultValue: 300,
    );

    controller = WebViewController()
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
            final result = await controller?.runJavaScriptReturningResult(
              "window.document.getElementsByTagName('html')[0].outerHTML;",
            );
            String html = result.toString();
            html = html.replaceAll(r'\"', '"'); // remove escaped quotes
            html = html.replaceAll('"', '');
            final urlRegex = RegExp(
              r"""https?:\/\/[^\s"\'<>]+""",
              caseSensitive: false,
            );
            final matches = urlRegex.allMatches(html);
            final urls = matches.map((m) => m.group(0)!).toList();
            print("HOHOHOIHEIh: 1$urls");

            // Filter by keywords commonly used in license servers
            final filtered = urls.where((url) {
              return url.contains("license") ||
                  url.contains("lic") ||
                  url.contains("drm") ||
                  url.contains("widevine") ||
                  url.contains("wv") ||
                  url.endsWith(".php") ||
                  url.endsWith(".json") ||
                  url.endsWith(".bin") ||
                  url.endsWith(".key");
            }).toList();
            print("HOHOHOIHEIh: 2$filtered");

            final patterns = [
              RegExp(
                r'Bearer\s+([A-Za-z0-9\-\._~+/]+=*)',
                caseSensitive: false,
              ),
              RegExp(r'"token"\s*:\s*"([^"]+)"', caseSensitive: false),
              RegExp(
                r'Authorization"\s*:\s*"Bearer\s+([^"]+)',
                caseSensitive: false,
              ),
              RegExp(r'accessToken"\s*:\s*"([^"]+)"', caseSensitive: false),
              RegExp(r'"auth"\s*:\s*"([^"]+)"', caseSensitive: false),
            ];

            for (final p in patterns) {
              final m = p.firstMatch(html);
              if (m != null) print("HOHOHOIHEIh: 1$m");
            }
            // final videoRegex = RegExp(
            //   r"""https?:\/\/[^\s"\'<>]+?\.(m3u8|mpd)""",
            //   caseSensitive: false,
            // );

            // final match = videoRegex.firstMatch(html);
            // final playerHtml = match?.group(0);

            controller?.runJavaScript(_robustInjectionScript);
            adInit(context);

            _loading = false;
            notify();
          },
          onWebResourceError: (WebResourceError error) {
            _loading = false;
            notify();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
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
    timer?.cancel();
    nb.setValue(cricketStreamingSecondKey, _lastStreamingSeconds);
  }

  void adInit(BuildContext context) {
    timer = Timer.periodic(1.seconds, (t) async {
      _lastStreamingSeconds--;
      nb.log("adInit: $_lastStreamingSeconds");
      if (_lastStreamingSeconds % 300 == 0) {
        timer?.cancel();
        Ads.showInterstitialAd(
          true,
          onDismiss: () async {
            _lastStreamingSeconds = 300;
            adInit(context);
            await Future.delayed(100.milliseconds);
          },
        );
      }
    });
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}

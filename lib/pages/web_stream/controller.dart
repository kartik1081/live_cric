import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:webview_flutter/webview_flutter.dart';

class WebStreamController extends ChangeNotifier {
  late final String url;
  bool _mounted = false;
  bool _loading = true;
  int _lastStreamingSeconds = 300;
  WebViewController? controller;
  int _reloadAttempts = 0;
  static const int _maxReloadAttempts = 1;

  bool get loading => _loading;

  WebStreamController(BuildContext context, {required this.url}) {
    _mounted = true;
    _lastStreamingSeconds = nb.getIntAsync(
      cricketStreamingSecondKey,
      defaultValue: 300,
    );

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
            await controller?.runJavaScript(_blockAdsScript);
            await controller?.runJavaScript(_hideTelegramPopupScript);
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
            final reqUrl = request.url;

            // Block YouTube embeds if you want
            if (reqUrl.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }

            // Block ad / popup URLs
            if (_isAdUrl(reqUrl) || _isNewWindowBlocked(reqUrl)) {
              nb.log("Blocked Ad URL: $reqUrl");

              // Optional: open ads externally instead
              // launchUrl(Uri.parse(reqUrl), mode: LaunchMode.externalApplication);

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
  String get _blockAdsScript => """
(function () {
  console.log('Ad & Popup blocker injected');

  window.open = function() { return null; };

  document.addEventListener('click', function(e) {
    const a = e.target.closest('a');
    if (a && a.target === '_blank') {
      e.preventDefault();
    }
  }, true);

  const originalAssign = location.assign;
  location.assign = function(url) {
    try {
      const u = new URL(url, location.href);
      if (u.origin !== location.origin) {
        console.log('Blocked cross-origin redirect:', url);
        return;
      }
      originalAssign.call(location, url);
    } catch (e) {}
  };
})();
""";
  String get _hideTelegramPopupScript => """
(function () {
  console.log('Telegram popup remover active');

  function removeTelegramPopup() {
    const keywords = ['telegram', 'join', 'already joined', 'continue'];

    const elements = document.querySelectorAll('div, button, a');

    elements.forEach(el => {
      const text = (el.innerText || '').toLowerCase();

      if (keywords.some(k => text.includes(k))) {
        // Try clicking buttons
        if (el.tagName === 'BUTTON' || el.tagName === 'A') {
          el.click();
        }

        // Hide containers
        if (el.style) {
          el.style.display = 'none';
          el.style.visibility = 'hidden';
        }
      }
    });

    // Remove fixed overlays
    document.querySelectorAll('*').forEach(el => {
      const style = window.getComputedStyle(el);
      if (style.position === 'fixed' && style.zIndex > 1000) {
        el.style.display = 'none';
      }
    });
  }

  // Run multiple times (these popups load late)
  setInterval(removeTelegramPopup, 1000);
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
    nb.setValue(cricketStreamingSecondKey, _lastStreamingSeconds);
  }

  bool _isAdUrl(String url) {
    final u = url.toLowerCase();

    const adKeywords = [
      "doubleclick",
      "adsystem",
      "googlesyndication",
      "adservice",
      "popup",
      "promo",
      "tracking",
      "redirect",
      "aff",
      "offer",
    ];

    return adKeywords.any((k) => u.contains(k));
  }

  bool _isNewWindowBlocked(String url) {
    return url.startsWith("about:blank") || url.contains("newtab");
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}

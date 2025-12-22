import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:nb_utils/nb_utils.dart';

Future<http.Response> buildHttpResponse(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map<String, String>? header,
}) async {
  var headers = header ?? await buildHeaderTokens();
  Uri url = buildBaseUrl(endPoint);

  http.Response response;

  try {
    if (method == HttpMethodType.POST) {
      response = await http.post(
        url,
        body: jsonEncode(request),
        headers: headers,
      );
    } else if (method == HttpMethodType.DELETE) {
      response = await http.delete(url, headers: headers);
    } else if (method == HttpMethodType.PUT) {
      response = await http.put(
        url,
        body: jsonEncode(request),
        headers: headers,
      );
    } else if (method == HttpMethodType.PATCH) {
      response = await http.patch(
        url,
        body: jsonEncode(request),
        headers: headers,
      );
    } else {
      response = await http.get(url, headers: headers);
    }

    Configs.analytics.logEvent(
      name: "${DateTime.now().month}-month",
      parameters: {"endpoint": endPoint, "status_code": response.statusCode},
    );
    Configs.analytics.logEvent(
      name: "${DateTime.now().weekday}-week",
      parameters: {"endpoint": endPoint, "status_code": response.statusCode},
    );
    Configs.analytics.logEvent(
      name: "${DateTime.now().day}-day",
      parameters: {"endpoint": endPoint, "status_code": response.statusCode},
    );
    apiPrint(
      url: url.toString(),
      endPoint: endPoint,
      headers: jsonEncode(headers),
      hasRequest: method == HttpMethodType.POST || method == HttpMethodType.PUT,
      request: jsonEncode(request),
      statusCode: response.statusCode,
      responseBody: response.body,
      methodtype: method.name,
    );
    return response;
  } catch (e, s) {
    log(e);
    Configs.crashlytics.recordError(e, s, reason: "network_utils");
    throw errorSomethingWentWrong;
  }
}

Future<Map<String, String>> buildHeaderTokens() async {
  await initialize();
  Map<String, String> header = {};

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  header.putIfAbsent(xRapidapiHostKey, () => RemoteConfigs.xRapidapiHostRc);
  header.putIfAbsent(xRapidapiKey, () => RemoteConfigs.xRapidapiKeyRc);

  log(jsonEncode(header));
  return header;
}

Map<String, String> defaultHeaders() {
  Map<String, String> header = {};

  header.putIfAbsent(HttpHeaders.cacheControlHeader, () => 'no-cache');
  header.putIfAbsent('Access-Control-Allow-Headers', () => '*');
  header.putIfAbsent('Access-Control-Allow-Origin', () => '*');

  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) {
    url = Uri.parse('${Configs.baseURL}$endPoint');
  }

  log('URL: ${url.toString()}');

  return url;
}

void apiPrint({
  String url = "",
  String endPoint = "",
  String headers = "",
  String request = "",
  int statusCode = 0,
  String responseBody = "",
  String methodtype = "",
  bool hasRequest = false,
}) {
  log(
    "┌───────────────────────────────────────────────────────────────────────────────────────────────────────",
  );
  log("\u001b[93mUrl: \u001B[39m $url");
  log("\u001b[93mHeader: \u001B[39m \u001b[96m$headers\u001B[39m");
  if (request.isNotEmpty) {
    log("\u001b[93mRequest: \u001B[39m \u001b[96m$request\u001B[39m");
  }
  log('Response ($methodtype) $statusCode: $responseBody');
  log(
    "└───────────────────────────────────────────────────────────────────────────────────────────────────────",
  );
}

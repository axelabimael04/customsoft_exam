import 'dart:convert';

import 'package:customsoft_exam/src/services/data/http_service/headers/header.dart';
import 'package:customsoft_exam/src/services/data/http_service/headers/header_types/content_type_headers.dart';
import 'package:customsoft_exam/src/services/data/server.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response> post(HttpServiceArgs settings,
      {bool enableEncoding = false}) {
    return http.post(
        Uri.https(ServerConstants.serverContext, settings.path,
            settings.queryParameters),
        headers: settings.headers.getAllHeaders(),
        body: jsonEncode(settings.body),
        encoding: enableEncoding ? Encoding.getByName("utf-8") : null);
  }

  static Future<http.Response> put(HttpServiceArgs settings) =>
      http.put(Uri.parse("${ServerConstants.server}${settings.path}"),
          headers: settings.headers.getAllHeaders(),
          body: jsonEncode(settings.body));

  static Future<http.Response> get(HttpServiceArgs settings) => http.get(
      Uri.https(ServerConstants.serverContext, settings.path,
          settings.queryParameters),
      headers: settings.headers.getAllHeaders());
}

class HttpServiceArgs {
  final String path;
  final HttpServiceHeaders headers;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;

  HttpServiceArgs({
    required this.path,
    required this.headers,
    this.body,
    this.queryParameters,
  });
}

class HttpServiceHeaders {
  ContentTypeHeader contentType;
  AuthorizationHeader? authorization;

  HttpServiceHeaders({required this.contentType, this.authorization});

  Map<String, String> getAllHeaders() {
    Map<String, String> allHeaders = {};
    allHeaders.addAll(ContentType(this.contentType).header);
    if (this.authorization != null)
      allHeaders.addAll(Authorization(this.authorization!).header);
    return allHeaders;
  }
}

class Authorization extends CustomHeaders<AuthorizationHeader> {
  late Map<String, String> header;
  AuthorizationHeader selection;

  Authorization(this.selection) : super(selection) {
    for (AuthorizationSelections selection in AuthorizationSelections.values) {
      if (this.selection.headerType == selection) {
        this.header = this.selection.getHeader;
        continue;
      }
    }
  }
}

abstract class AuthorizationHeader implements Header<AuthorizationSelections> {}

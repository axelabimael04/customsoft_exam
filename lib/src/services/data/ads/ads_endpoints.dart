import 'dart:convert';
import 'package:customsoft_exam/src/services/data/http_service/actions/http_service.dart';
import 'package:customsoft_exam/src/services/data/http_service/headers/header_types/content_type_headers.dart';
import 'package:customsoft_exam/src/services/data/server.dart';
import 'package:http/http.dart' as http;

class AdsEndpoints {
  static Future<Map<String, dynamic>?> getAllAds() async {
    http.Response resp;
    try {
      resp = await HttpService.get(
        HttpServiceArgs(
          path: ServerPaths.getAllAds,
          headers: HttpServiceHeaders(contentType: AplicationJson()),
        ),
      );

      Map<String, dynamic> data = jsonDecode(resp.body);

      if (resp.statusCode != 200) return null;

      return data;
    } catch (e) {
      print("Error on AdsEndpoints.getAllAds: $e");
      return null;
    }
  }
}

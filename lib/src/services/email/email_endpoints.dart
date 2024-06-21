import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJSEndpoints {
  static Future<bool> sendEmail(
      {required Map<String, dynamic> emailData, required String tempalteID}) async {
    http.Response resp;
    try {
      resp = await http.post(
        Uri.parse("https://api.emailjs.com/api/v1.0/email/send"),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'service_id': 'service_hi5j9vf',
          'template_id': tempalteID,
          'user_id': 'mbiy0If-VHla4PpVM',
          'template_params': emailData
        }),
      );

      if (resp.statusCode != 200) return false;

      return true;
    } catch (e) {
      print("Error on EmailJSEndpoints.sendEmail: $e");
      return false;
    }
  }
}

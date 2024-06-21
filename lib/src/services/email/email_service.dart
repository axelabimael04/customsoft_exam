import 'package:customsoft_exam/src/services/email/email_endpoints.dart';

class EmailSerivce {
  static Future<bool> sendBasicEmail(EmailData emailData) async {
    try {
      bool resp = await EmailJSEndpoints.sendEmail(
          emailData: emailData.toMap(), tempalteID: 'template_agjhzz6');

      return resp;
    } catch (e) {
      print("Error EmailSerivce.sendBasicEmail $e");
      throw e;
    }
  }
}

class EmailData {
  final String emailTo;
  final FormContact contact;

  EmailData({required this.emailTo, required this.contact});

  Map<String, dynamic> toMap() {
    return {
      'email_to': emailTo,
      'email': contact.email,
      'name': contact.name,
      'message': contact.message,
    };
  }
}

class FormContact {
  final String email;
  final String name;
  final String message;

  FormContact({
    required this.email,
    required this.name,
    required this.message,
  });
}

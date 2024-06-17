import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String formatCurrency(double number) {
    String numberStr =
        number % 1 == 0 ? number.toInt().toString() : number.toString();

    NumberFormat formatter = NumberFormat('#,##0', 'en_US');

    String formattedNumber = formatter.format(int.parse(numberStr));

    return '\$' + formattedNumber;
  }
}

class LaunchService {
  static Future<void> call(String phone) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendMail(
    String to, {
    required String subject,
    required String body,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: to,
      query: 'subject=$subject&body=$body',
    );
    await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
  }
}

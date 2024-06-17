import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationServiceManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermisions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    ).then((value) {
      print(value.authorizationStatus);
    },);
  }

  Future<void> generateToken(BuildContext context) async {
    try {
      String? token;
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        await FirebaseMessaging.instance.getAPNSToken().then((value) async {
          if (value != null) {
            token = await _firebaseMessaging.getToken();
            print(token);
          }
        }).catchError((error) {
          print("APNS error: $error");
        });
      } else {
        token = await _firebaseMessaging.getToken().then((value) {
          print(value);
          return value;
        },);
      }
    } catch (e) {
      print(e);
    }
  }
}

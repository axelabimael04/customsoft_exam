import 'package:customsoft_exam/src/services/notifications/notification_manager.dart';
import 'package:customsoft_exam/src/services/notifications/notifications_config.dart';
import 'package:customsoft_exam/src/pages/menu_navigation_page.dart.dart';
import 'package:customsoft_exam/src/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationsConfig.init(DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServiceManager _pushNotifications = NotificationServiceManager();

  @override
  void initState() {
    super.initState();
    _pushNotifications.requestNotificationPermisions();
  }

  @override
  Widget build(BuildContext context) {
    NotificationServiceManager().generateToken(context);
    return MaterialApp(
      theme: CustomTheme.define(),
      debugShowCheckedModeBanner: false,
      title: 'CUSTOMSOFT',
      home: MenuNavigationPage(),
    );
  }
}

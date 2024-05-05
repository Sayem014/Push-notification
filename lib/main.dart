import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/firebase_options.dart';
import 'package:pushnotification/home_page.dart';
import 'package:pushnotification/message_page.dart';
import 'package:pushnotification/push_notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('some notifications received');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('background notification tapped');
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotInit();
  // listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'push notification',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/message': (context) => const MessagePage()
      },
    );
  }
}

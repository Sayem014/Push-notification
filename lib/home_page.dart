import 'package:flutter/material.dart';
//import 'package:pushnotification/main.dart';
import 'package:pushnotification/push_notification.dart';
//import 'package:pushnotification/push_notifications.dart'; // Assuming your push notifications class is in push_notifications.dart

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Push Notification')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const Text('Let\'s learn push notifications'),
            ElevatedButton(
              onPressed: _showPushNotification,
              child: const Text('Send Push Notification'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPushNotification() {
    // Trigger push notification
    PushNotifications.showSimpleNotification(
      title: 'New Notification',
      body: 'This is a push notification!',
      payload:
          'notification_payload', // You can customize the payload as needed
    );
  }
}

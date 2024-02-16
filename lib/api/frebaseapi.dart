import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title:${message.notification?.title}');
  print('Body:${message.notification?.body}');
  print('Payload:${message.data}');
}

class Firebaseapi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcm = await firebaseMessaging.getToken();
    print('token:$fcm');
    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackgroundMessage(message));
  }
}

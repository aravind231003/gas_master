import 'dart:convert';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'acces_firebase_token.dart';

class Firebaseapi {
  String fcm = '';
  var _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
  }

  Future<void> initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground message
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    var channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000000).toString(), 'High Importance',
        importance: Importance.max);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    });
  }

  sendDataToFirebase(data, var node, var sensor) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    // Assuming 'sensorData' is the node where data will be stored
    databaseReference.child('$node').set({
      '$sensor': data,
      // Add more data fields as needed
    }).then((value) {
      print('Data sent successfully');
    }).catchError((error) {
      print('Failed to send data: $error');
    });
  }

  void background() {
    FirebaseMessaging.onBackgroundMessage((message) async {
      print('Received background message: ${message.notification?.title}');
    });
  }

  Future<void> sendPushNotification(String Title, String text) async {
    AccessFirebaseToken accessToken = AccessFirebaseToken();
    final _firebaseMessaging = FirebaseMessaging.instance;
    final fcm = await _firebaseMessaging.getToken();
    String bearerToken = await accessToken.getAccessToken();
    final body = {
      "message": {
        "token": "$fcm",
        "notification": {"title": "$Title", "body": "$text"},
      }
    };
    try {
      var res = await post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/gas-master/messages:send'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(body),
      );
      print("Response statusCode: ${res.statusCode}");
      print("Response body: ${res.body}");
    } catch (e) {
      print("\nsendPushNotification: $e");
    }
  }
}
